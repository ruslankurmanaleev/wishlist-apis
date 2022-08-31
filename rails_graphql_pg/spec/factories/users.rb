FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    name { "Test User" }
  end
end
