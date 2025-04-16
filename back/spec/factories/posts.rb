FactoryBot.define do
  factory :post do
    content_text { Faker::Lorem.sentence(word_count: 10) }
    user
  end
end
