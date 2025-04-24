class PointTransaction < ApplicationRecord
  belongs_to :user

  enum :transaction_type, {
    other: 0, #使う機会はないと思うが一応
    post_create: 1,
    post_like: 2,
    item_purchase: 3,
    group_create_fee: 4,
    group_join_fee: 5,
    admin_adjust: 6,
    initial_bonus: 7,
    other_bonus: 8
  }

  enum :entity_type, {post: 0, item: 1, room: 2, user: 3, admin: 4}

  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :user_id, presence: true
  validates :point_change, presence: true, numericality: { only_integer: true }
  validates :transaction_type, presence: true, inclusion: { in: transaction_types.keys }
  validates :entity_type, presence: true, inclusion: { in: entity_types.keys }

  private

end
