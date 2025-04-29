FactoryBot.define do
  factory :group do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.sentence(word_count: 10) }
    join_fee { Faker::Number.number(digits: 3) }
    max_group_member { Faker::Number.number(digits: 2) }
  end
end
