class PointTransactionsController < ApplicationController
  # 履歴を削除することは不可能
  
  def create
  end

  private

  def point_transaction_params
    params.require(:point_transaction).permit(
      :point_change,
      :transaction_type,
      :entity_type,
      :description,
      :processed_by_admin_id
    )
  end
end
