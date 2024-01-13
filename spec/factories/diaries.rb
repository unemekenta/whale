# spec/factories/diaries.rb
FactoryBot.define do
  factory :diary do
    title { ::EnFaker::Lorem.sentence }
    content { ::EnFaker::Lorem.paragraph }
    is_public { true }
    date { ::EnFaker::Time.forward(days: 7) }
    association :user
  end
end