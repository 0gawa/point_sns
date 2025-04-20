FactoryBot.define do
  factory :point_transaction do
    point_change { Faker::Number.number(digits: 3) }
    transaction_type { :other } 
    entity_type { :post }
    description { Faker::Lorem.sentence(word_count: 10) }
    processed_by_admin_id { 0 }
    user
  end
end
