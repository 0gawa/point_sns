class PointTransaction < ApplicationRecord
  belongs_to :user

  enum transaction_type: {
    others: 0 #使う機会はないと思うが一応
    post_create: 1,
    post_like: 2,
    item_purchase: 3,
    group_create_fee: 4,
    group_join_fee: 5,
    admin_adjust: 6,
    initial_bonus: 7,
    other_bonus: 8
  }

  enum entity_type: {
    post: 0, item: 1, group: 2, user: 3, admin: 4
  }

  validates :user_id, presence: true
  validates :point_change, presence: true
  validates :transaction_type, presence: true
  validates :entity_type, presence: true
  validates :description, length: { maximum: 500 }, allow_blank: true
end
