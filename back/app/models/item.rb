class Item < ApplicationRecord
  has_many :user_items, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :item_type, presence: true, inclusion: { in: %w[badge stamp frame trophy] }
  validates :is_sale, inclusion: { in: [true, false] }

  enum :item_type, {badge:0, stamp:1, frame:2, trophy:3}
end
