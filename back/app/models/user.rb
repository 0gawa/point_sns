# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :point_transactions, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 300 }
  validates :is_active, inclusion: { in: [true, false] }
  validates :all_points, numericality: { only_integer: true }
  validates :points_balance, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :trust_score, presence: true
  validates :role, inclusion: { in: %w[user admin] }
  validates :point_rate, presence: true, numericality: { greater_than_or_equal_to: 1.0 }
  
  # Coution: 以下の記述以外でenumを定義するとバグが発生する
  enum :role, { user: 0, admin: 1 }

  private

  def add_all_points(points)
    self.all_points += points
    save
  end

  def add_points_balance(points)
    self.points_balance += points
    save
  end

  def subtract_points_balance(points)
    self.points_balance -= points
    save
  end

  def add_point_rate(up_rate)
    self.point_rate += up_rate
    save
  end

  def subtract_point_rate(down_rate)
    self.point_rate -= down_rate
    save
  end
end
