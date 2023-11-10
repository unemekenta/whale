# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    status { 'not_started' }
    priority { 'normal' }
    deadline { Faker::Time.forward(days: 7) }
    association :user
  end
end