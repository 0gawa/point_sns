FactoryBot.define do
  factory :follow do
    followed_user { create(:user) }
    follower_user { create(:user) }
  end
end
