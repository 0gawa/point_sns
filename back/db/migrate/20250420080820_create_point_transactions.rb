class CreatePointTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :point_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :point_change, null: false
      t.integer :transaction_type, null: false
      t.integer :entity_type, null: false
      t.integer :entity_id

      # 管理者がポイントを付与した場合のみ使用
      t.text :description
      t.integer :processed_by_admin_id

      t.timestamps
    end
  end
end
