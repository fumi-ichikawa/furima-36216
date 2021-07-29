FactoryBot.define do
  factory :item do
    image {Faker::Lorem.sentence}
    title {Faker::Lorem.sentence}
    description {Faker::Lorem.sentence}
    category_id {Faker::Number.between(from: 2, to: 11)}
    status_id {Faker::Number.between(from: 2, to: 7)}
    postage_id {Faker::Number.between(from: 2, to: 3)}
    ship_region_id {Faker::Number.between(from: 2, to: 48)}
    shipping_date_id {Faker::Number.between(from: 2, to: 4)}
    price {Faker::Number.between(from: 300, to: 9999999)}

    association :user 
  end
end
