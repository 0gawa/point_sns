class Point::SaveAdminPointService
  def initialize(admin_id, point_change, description)
    @admin_id = admin_id
    @point_change = point_change
    @description = description
  end

  def call(user_id)
    point_transaction = PointTransaction.new()
    point_transaction.user_id = user_id
    point_transaction.point_change = @point_change
    point_transaction.processed_by_admin_id = @admin_id
    point_transaction.description = @description
    point_transaction.transaction_type = PointTransaction.transaction_types[:admin]
    unless point_transaction.save
      raise ActiveRecord::Rollback
      return
    end
    unless cal_user_point_transaction(user_id)
      PointTransaction.find(point_transaction.id).destroy
      raise ActiveRecord::Rollback
      return
    end
  end

  private

  def cal_user_point_transaction(user_id)
    user = User.find(user_id)
    user.add_points_balance(@point_change)
    user.save
  end
end
