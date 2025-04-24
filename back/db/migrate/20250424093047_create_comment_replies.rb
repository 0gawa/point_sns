class CreateCommentReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :comment_replies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post_comment, null: false, foreign_key: true
      t.text :content, null: false
      
      t.timestamps
    end
  end
end
