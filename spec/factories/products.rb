FactoryBot.define do
  
  factory :product do
    user_id       {1}
    name          {"ジーンズ"}
    description   {"ああああああああああああああああああああああああああああああああああああ"}
    status        {1}
    category_id   {1}
    prefecture_id {1}
    cost          {1}
    days          {1}
    price         {"40000"}
  end
end