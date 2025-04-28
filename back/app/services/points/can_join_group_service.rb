class Points::CanJoinGroupService
  def initialize(user, cost)
    @user = user
    @cost = cost
  end

  def call
    is_less_than_point_balance
  end

  private

  def is_less_than_point_balance
    @cost < @user.points_balance
  end
end
