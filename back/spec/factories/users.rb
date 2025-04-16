FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    nickname { Faker::Internet.username(specifier: 5..10) }
    bio { Faker::Lorem.sentence(word_count: 10) }
    role { 0 }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
