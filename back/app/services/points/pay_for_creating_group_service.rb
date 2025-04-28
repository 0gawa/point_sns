class Points::PayForCreatingGroupService
  include IndexOfPointCost

  def initialize(user, group)
    @creating_group_cost = IndexOfPointCost.creating_group_cost
    @user = user
    @group = group
  end

  def call
    user.subtract_points_balance(@creating_group_cost)
    create_transaction
  end

  private

  def create_transaction
    transaction = PointTransaction.new()
    transaction.user_id = @user.id
    transaction = -@creating_group_cost # マイナスであることに注意
    transaction.transaction_type = :group_create_fee
    transaction.entity_type = :room
    transation.entity_id = @group.id
    transaction.description = "グループ作成に必要なポイント"
    
    transaction.save
  end
end
