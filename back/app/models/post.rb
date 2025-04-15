class Post < ApplicationRecord
  belongs_to :user

  validates :content_text, presence: true, length: { maximum: 300 }

  def like_count
    # TO DO: Implement the logic to count likes for the post
  end
end
