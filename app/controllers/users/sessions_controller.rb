class Users::SessionsController < Devise::SessionsController
  respond_to :json
  prepend_before_action :check_captcha, only: [:create]
  before_action :ensure_mandatory_user_otp!

  def create
    self.resource = warden.authenticate!(auth_options)
    if resource.otp_required_for_login
      resource.send_new_otp
      render json: { message: 'Signin successful. OTP sent to your email.' }, status: :ok
    else
      sign_in(resource_name, resource)
      respond_with(resource, auth_options)
    end
  end
  
  def verify_otp
    self.resource = User.find_by(email: params[:email])
    
    if resource&.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(resource_name, resource)
      render json: { message: 'OTP verified successfully.', token: current_token }, status: :ok
    else
      render json: { error: 'Invalid OTP' }, status: :unprocessable_entity
    end
  end

  def respond_with(resource, _opts = {})    
    render json: {
      message: "Logged in successfully",
      user: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first     
    current_user = User.find(jwt_payload['sub'])
    if current_user
      render json: {
        message: "logged out successfully",
        user: current_user
      }, status: :ok                  
    else
      render json: {
        message: "User has no active session",
        user: current_user
      }, status: :ok       
    end
  end

  private

  def check_captcha
    return if verify_recaptcha # verify_recaptcha(action: 'login') for v3

    self.resource = resource_class.new sign_in_params

    respond_with_navigational(resource) do
      flash.discard(:recaptcha_error) # We need to discard flash to avoid showing it on the next page reload
      render :new
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
