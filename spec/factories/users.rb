# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    provider { 'email' }
    uid { Faker::Internet.email }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end