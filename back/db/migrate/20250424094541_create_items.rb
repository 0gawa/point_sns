class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description
      t.integer :item_type, null: false
      t.integer :price, null: false
      t.boolean :is_sale, null: false, default: true

      t.timestamps
    end
  end
end
