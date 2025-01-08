FactoryBot.define do
  factory :payment do
    name { "Sample Payment" }
    number { "1234567890123456" }
    due_date { "2025-01-01" }
    cvc { "123" }
    amount { 100.00 }
    status { :pending }
  end
end
