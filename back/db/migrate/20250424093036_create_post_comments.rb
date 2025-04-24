class CreatePostComments < ActiveRecord::Migration[8.0]
  def change
    create_table :post_comments do |t|
      t.timestamps
    end
  end
end
