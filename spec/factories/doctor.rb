FactoryBot.define do
  factory :doctor do
    specialization { Faker::Lorem.word }
    clinic_name { Faker::Company.name }
    user_id { association(:user).id }
    
  end    
end
