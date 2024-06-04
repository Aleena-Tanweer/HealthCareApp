FactoryBot.define do
    factory :rider do
      vehicle_type { Faker::Vehicle.car_type }
      area_of_coverage { Faker::Address.community }
      user_id { association(:user).id }
      lab_id { association(:lab).id }
      
    end
  end