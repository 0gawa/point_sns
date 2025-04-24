class GroupMember < ApplicationRecord
  belongs_to :group
  belongs_to :user

  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :role, presence: true, inclusion: { in: %w[admin member] }

  enum :role, { admin: 0, member: 1 }
end
