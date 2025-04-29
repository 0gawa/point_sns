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
    transaction.user_id = @user.id
    transaction = -@group.join_fee # マイナスであることに注意
    transaction.transaction_type = :group_join_fee
    transaction.entity_type = :room
    transation.entity_id = @group.id
    transaction.description = "グループ参加に必要なポイント取引"
    
    transaction.save
  end
end
