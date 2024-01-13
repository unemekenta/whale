# spec/factories/diary_comments.rb
FactoryBot.define do
  factory :diary_comment do
    content { ::EnFaker::Lorem.paragraph }
    association :user
    association :diary
  end
end