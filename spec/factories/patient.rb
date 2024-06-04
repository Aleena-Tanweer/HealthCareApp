FactoryBot.define do
    factory :patient do
      date_of_birth { Faker::Date.birthday }
      address { Faker::Address.full_address }
      contact_number { Faker::PhoneNumber.phone_number }
      fasting_requirements { [true, false].sample }
      user_id { association(:user).id }
  
    end
  end