class OrderPolicy < ApplicationPolicy
  def show?
    true
  end
  
  def create?
    user.doctor?
  end
  
  def update?
    user.doctor? || user.lab_staff?
  end
  
  def destroy?
    
    user.doctor? 
  end
end
  