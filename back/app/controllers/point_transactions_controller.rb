class PointTransactionsController < ApplicationController
  # 履歴を削除することは不可能
  before_action :authenticate_user!, only: [:create]
  
  def create
    @point_transaction = PointTransaction.new(point_transaction_params)
    @point_transaction.user_id = current_user.id

    # To Do: ユーザーのポイントロジックを実装する

    if @point_transaction.save!
      render json: @point_transaction, status: :created
    else
      render json: @point_transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def point_transaction_params
    params.require(:point_transaction).permit(
      :point_change,
      :transaction_type,
      :entity_type,
      :entity_id,
      :description,
      :processed_by_admin_id,
    )
  end
end
