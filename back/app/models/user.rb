# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 300 }
  validates :is_active, inclusion: { in: [true, false] }
  
  attribute :is_active, default: true

  # Coution: 以下の記述以外でenumを定義するとバグが発生する
  enum :role, { user: 0, admin: 1 }

  def add_to_all_points(points)
    self.all_points += points
    save
  end
end
