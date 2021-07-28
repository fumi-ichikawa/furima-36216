FactoryBot.define do
  factory :user do
    nickname { Faker::Name }
    email { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    first_name { Gimei.first.kanji }
    last_name { Gimei.last.kanji }
    first_name_kana { Gimei.first.katakana }
    last_name_kana { Gimei.last.katakana }
    birthday { Faker::Date.between(from: '1990-01-01', to: '2020-12-08') }
  end
end

# FactoryBot.define do
#   factory :user do
#     nickname              {"やまもと"}
#     email                 {"kkk@gmail.com"}
#     password              {"00000000"}
#     password_confirmation {"00000000"}
#     family_name           {"田中"}
#     first_name            {"花子"}
#     family_name_kana      {"タナカ"}
#     first_name_kana       {"ハナコ"}
#     birthday              {"2020-08-04"}
#   end
# end
