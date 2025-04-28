FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 10) }
    description { Faker::Lorem.sentence(word_count: 10) }
    item_type {:badge}
    price { Faker::Number.number(digits: 3) }
    is_sale { true }
  end
end
