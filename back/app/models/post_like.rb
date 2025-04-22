class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  private
  
  # ユーザーが特定の投稿をいいねしているかどうかを確認するメソッド
  def self.user_liked?(user_id, post_id)
    exists?(user_id: user_id, post_id: post_id)
  end
end
