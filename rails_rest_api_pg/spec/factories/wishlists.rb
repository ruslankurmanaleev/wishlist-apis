FactoryBot.define do
  factory :wishlist do
    association :user

    title { "My best wishlist" }
    publicity_level { 0 }
    status { 0 }
  end
end
