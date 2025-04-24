class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :comment_replies, dependent: :destroy

  validates :content, presence: true, length: { maximum: 300 }
end
