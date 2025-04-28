FactoryBot.define do
  factory :group_member do
    role { :member }
    user
    group
  end
end
