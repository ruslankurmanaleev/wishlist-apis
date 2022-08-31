FactoryBot.define do
  factory :item do
    association :user
    association :wishlist

    title { "Nice gift" }
    link { "https://ozon.ru/" }
    description { "I need it so bad!" }
    status { 0 }
    reserved_by { 0 }
    gifted_by { 0 }
    reserved_on { "2022-08-13 16:10:29" }
    gifted_on { "2022-08-13 16:10:29" }
  end
end
