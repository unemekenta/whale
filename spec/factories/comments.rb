# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    content { ::EnFaker::Lorem.paragraph }
    association :user
    association :task
  end
end