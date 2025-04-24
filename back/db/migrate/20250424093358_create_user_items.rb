class CreateUserItems < ActiveRecord::Migration[8.0]
  def change
    create_table :user_items do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.boolean :is_equipped, null: false, default: false
      
      t.timestamps
    end
  end
end
