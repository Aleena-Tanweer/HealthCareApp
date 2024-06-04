FactoryBot.define do
    factory :lab do
      name { Faker::Company.name }
      country_code { Faker::Address.country_code }
    end
  end