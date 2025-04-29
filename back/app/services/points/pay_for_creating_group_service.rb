class Points::PayForCreatingGroupService
  def initialize(user, group)
    @creating_group_cost = IndexOfPointCost.new().creating_group_cost
    @user = user
    @group = group
  end

  def call
    @user.subtract_points_balance(@creating_group_cost)
    create_transaction
  end

  private

  def create_transaction
    transaction = PointTransaction.new()
    transaction.user_id          = @user.id
    transaction.point_change     = -@creating_group_cost # マイナスであることに注意
    transaction.transaction_type = get_transaction_type_of_group_create_fee
    transaction.entity_type      = get_entity_type_of_room
    transaction.entity_id        = @group.id
    transaction.description      = "グループ作成に必要なポイント取引"
    
    transaction.save
  end

  def get_transaction_type_of_group_create_fee
    PointTransaction.transaction_types[:group_create_fee]
  end

  def get_entity_type_of_room
    PointTransaction.entity_types[:room]
  end
end
