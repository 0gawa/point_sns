class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content_text, null: false, default: ""
      t.integer :like_count, null: false, default: 0
      t.integer :comment_count, null: false, default: 0

      t.timestamps
    end
  end
end
