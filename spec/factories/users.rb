FactoryBot.define do

  factory :user do
    nickname {"フリマ太郎"}
    email {"test@google.com"}
    password {"12345678"}
    password_confirmation {"12345678"}
    family_name {"ふりま"}
    first_name {"たろう"}
    family_name_kana {"フリマ"}
    first_name_kana {"タロウ"}
    birth_day {"1994-09-29"}
  end

end