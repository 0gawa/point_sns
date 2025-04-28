FactoryBot.define do
  factory :comment_reply do
    content { Faker::Lorem.sentence(word_count: 50) }
    user
    post_comment
  end
end
