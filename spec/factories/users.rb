# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    provider { 'email' }
    uid { ::EnFaker::Internet.email }
    email { ::EnFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end