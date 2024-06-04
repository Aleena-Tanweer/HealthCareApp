class RiderPolicy
  attr_reader :user, :rider

  def initialize(user, rider)
    @user = user
    @rider = rider
  end

  def show?
    user.rider? 
  end

  def create?
    user.rider?
  end

  def update?
    user.rider? 
  end

  def destroy?
    user.rider?
  end


end

