class PatientPolicy
  attr_reader :user, :patient

  def initialize(user, patient)
    @user = user
    @patient = patient
  end

  def show?
    user.patient?
  end

  def create?
    user.patient?
  end

  def update?
    user.patient?
  end

  def destroy?
    user.patient?
  end

  def view_orders?
    user.patient?
  end

  def view_order_status?
    user.patient?
  end

  def view_test_results?
    user.patient?
  end

  def receive_feedback?
    user.patient?
  end  
end
