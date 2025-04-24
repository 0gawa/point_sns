class CommentReply < ApplicationRecord
  belongs_to :post_comment
  belongs_to :user

  validates :content, presence: true, length: { maximum: 300 }
  validates :user_id, presence: true
  validates :post_comment_id, presence: true
end
