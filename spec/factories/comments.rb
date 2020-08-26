FactoryBot.define do
  factory :comment do
    product { nil }
    user { nil }
    delete_check { 1 }
    comment { "MyString" }
  end
end
