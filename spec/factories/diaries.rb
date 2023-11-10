# spec/factories/diaries.rb
FactoryBot.define do
  factory :diary do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    is_public { true }
    date { Faker::Time.forward(days: 7) }
    association :user
  end
end