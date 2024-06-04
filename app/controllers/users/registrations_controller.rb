class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  # prepend_before_action :check_captcha, only: [:create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :ensure_mandatory_user_otp!

  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        resource.send_new_otp
        register_success(resource)
      else
        expire_data_after_sign_in!
        register_failed(resource)
      end
    else
      clean_up_passwords resource
      register_failed(resource)
    end
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :role, :password])
  end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def respond_with(resource, _opts = {})
    if resource.present?
      register_success(resource)
    else
      register_failed(resource)
    end
  end

  def register_success(resource)
    render json: {
      message: "Signed up successfully. OTP sent to your email.",
      user: resource,
      redirect_path: after_sign_up_path_for(resource)
    }, status: :ok
  end

  def register_failed(resource)
    render json: {
      message: "Something went wrong",
      errors: resource.errors.full_messages
    }, status: :unprocessable_entity
  end

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new(sign_up_params)
    resource.validate # Look for any other validation errors besides reCAPTCHA
    register_failed(resource)
  end

  def after_sign_up_path_for(resource)
    case resource.role
    when 'doctor'
      new_api_v1_doctor_path
    when 'patient'
      new_api_v1_patient_path
    when 'lab_staff'
      new_api_v1_lab_staff_path
    when 'rider'
      new_api_v1_rider_path
    end
  end
end
