# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :user
    association :task
  end
end