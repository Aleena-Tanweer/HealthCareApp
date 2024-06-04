class LabStaffPolicy
  attr_reader :user, :lab_staff

  def initialize(user, lab_staff)
    @user = user
    @lab_staff = lab_staff
  end

  def show?
    user.lab_staff? 
  end

  def create?
    user.lab_staff?
  end

  def update?
    user.lab_staff? 
  end

  def destroy?
    user.lab_staff?
  end

  
end
