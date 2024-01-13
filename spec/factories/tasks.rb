# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { ::EnFaker::Lorem.sentence }
    description { ::EnFaker::Lorem.paragraph }
    status { 'not_started' }
    priority { 'normal' }
    deadline { ::EnFaker::Time.forward(days: 7) }
    association :user
  end
end