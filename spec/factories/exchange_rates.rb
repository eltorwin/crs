FactoryBot.define do
  factory :exchange_rate do
    current_value { 102.02 }
    current_rate { :rub_usd }
    parse_at { Date.current }
  end
end
