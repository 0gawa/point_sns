class Post < ApplicationRecord
  belongs_to :user

  has_many :post_likes, dependent: :destroy
  has_many :liked_users, through: :post_likes, source: :user
  has_many :post_comments, dependent: :destroy

  has_many_attached :images

  validates :content, presence: true, length: { maximum: 300 }
  validates :user_id, presence: true

  private

  def like_count
    # TO DO: Implement the logic to count likes for the post
  end
end
