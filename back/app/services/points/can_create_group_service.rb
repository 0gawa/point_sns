class Points::CanCreateGroupService
  def initialize(user)
    @user = user
  end

  def call
    is_less_than_point_balance
  end

  private

  def is_less_than_point_balance
    IndexOfPointCost.new.creating_group_cost < @user.points_balance
  end
end
