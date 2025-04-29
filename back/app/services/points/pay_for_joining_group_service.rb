class Points::PayForJoiningGroupService
  def initialize(user, group)
    @user = user
    @group = group
  end

  def call
    @user.subtract_points_balance(@group.join_fee)
    create_transaction
  end

  private

  def create_transaction
    transaction = PointTransaction.new()
    transaction.user_id          = @user.id
    transaction.point_change     = -@group.join_fee # マイナスであることに注意
    transaction.transaction_type = get_transaction_type_of_group_create_fee
    transaction.entity_type      = get_entity_type_of_room
    transaction.entity_id        = @group.id
    transaction.description      = "グループ参加に必要なポイント取引"
    
    transaction.save
  end

  def get_transaction_type_of_group_create_fee
    PointTransaction.transaction_types[:group_join_fee]
  end

  def get_entity_type_of_room
    PointTransaction.entity_types[:room]
  end
end
