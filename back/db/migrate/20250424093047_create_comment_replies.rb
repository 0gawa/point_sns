class CreateCommentReplies < ActiveRecord::Migration[8.0]
  def change
    create_table :comment_replies do |t|
      t.timestamps
    end
  end
end
