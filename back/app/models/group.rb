class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_members
  has_many :users, through: :group_members

  has_one_attached :image

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :creator_user_id, presence: true
  validates :join_fee, presence: true, numericality: { only_integer: true,  greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
  validates :max_group_member, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 100 }
end
