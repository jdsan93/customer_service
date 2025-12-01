FactoryBot.define do
  factory :customer do
    customer_name { "Customer #{SecureRandom.hex(4)}" }
    address { "123 Main St" }
    orders_count { 0 }
  end
end
FactoryBot.define do
  factory :customer do
    customer_name { "MyString" }
    address { "MyString" }
    orders_count { 1 }
  end
end
