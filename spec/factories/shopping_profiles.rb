FactoryBot.define do
  factory :shopping_profile do
    
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { '123-4567' }
    ship_region_id { Faker::Number.between(from: 2, to: 48) }
    city { Faker::Address.city }
    address { Faker::Address.street_name }
    building_name { '東京ハイツ' }
    phone { '09012345678' }

  end
end
