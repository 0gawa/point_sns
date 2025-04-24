class CreateGroupMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :group_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :group,null: false, foreign_key: true
      t.integer :role, null: false

      t.timestamps
    end
  end
end
