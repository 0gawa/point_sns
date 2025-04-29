class PointTransactionsController < ApplicationController
  # 履歴を削除することは不可能
  before_action :authenticate_v1_user!, only: [:create]
  
  def create
    @point_transaction = PointTransaction.new(point_transaction_params)
    @point_transaction.user_id = current_v1_user.id

    if @point_transaction.transaction_type == PointTransaction.transaction_types[:item_purchase]
    elsif @point_transaction.transaction_type == PointTransaction.transaction_types[:post_create]
      normal_point_service = Points::GetNormalPointService.new(current_v1_user.point_rate)
      cal_point = normal_point_service.call(@point_transaction.point_change)
      @point_transaction.point_change = cal_point
    elsif @point_transaction.transaction_type == PointTransaction.transaction_types[:post_like]
    elsif @point_transaction.transaction_type == PointTransaction.transaction_types[:admin_adjust]
    elsif @point_transaction.transaction_type == PointTransaction.transaction_types[:initial_bonus]
    end

    if @point_transaction.save
      render json: @point_transaction, status: :created
    else
      render json: { error: 'Unable to add this point transaction' }, status: :unprocessable_entity
    end
  end

  private

  def point_transaction_params
    params.require(:point_transaction).permit(:point_change, :transaction_type, :entity_type, :entity_id)
  end
end
