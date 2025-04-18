class Post < ApplicationRecord
  belongs_to :user

  has_many :post_likes, dependent: :destroy
  # postに対していいねしたユーザーを取得するためのアソシエーション
  has_many :liked_users, through: :post_likes, source: :user

  has_many_attached :images

  validates :content_text, presence: true, length: { maximum: 300 }

  def like_count
    # TO DO: Implement the logic to count likes for the post
  end
end
