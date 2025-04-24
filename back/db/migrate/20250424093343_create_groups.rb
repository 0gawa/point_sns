class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.text :description
      t.integer :creator_user_id, null: false
      t.integer :join_fee, null: false, default: 0
      t.integer :max_group_member, null: false, default: 2

      t.timestamps
    end
  end
end
