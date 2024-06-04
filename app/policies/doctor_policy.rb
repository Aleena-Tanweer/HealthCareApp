class DoctorPolicy < ApplicationPolicy
  attr_reader :user, :doctor

  def initialize(user, doctor)
    @user = user
    @doctor = doctor
  end

  def index?
    user.doctor? 
  end

  def show?
    user.doctor? 
  end

  def create?
    user.doctor? 
  end

  def new?
    create?
  end

  def update?
    user.doctor? 
  end

  def edit?
    update?
  end

  def destroy?
    user.doctor?
  end

  def place_order?
    user.doctor? 
  end

  def view_orders_status?
    user.doctor? 
  end

  def view_feedback?
    user.doctor? 
  end
end
