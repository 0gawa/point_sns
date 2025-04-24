class UserItem < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :is_equipped, inclusion: { in: [true, false] }
end
