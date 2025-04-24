class CreateAdminLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :admin_logs do |t|
      t.integer :admin_user_id, null: false
      t.integer :action_type, null: false
      t.text :description, null: false

      # nullを認めることに注意
      t.integer :target_user_id
      t.integer :target_group_id
      t.integer :target_post_id
      t.integer :target_item_id

      t.timestamps
    end
  end
end
