# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :nickname, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 300 }
end
