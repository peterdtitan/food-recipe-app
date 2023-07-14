FactoryBot.define do
    factory :food do
      name { 'Food 1' }
      quantity { 10 }
      measurement_unit { 'kg' }
      price { 5 }
    end
  end
