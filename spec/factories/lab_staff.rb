FactoryBot.define do
    factory :lab_staff do
      department { Faker::Job.field }
      user_id { association(:user).id }
      lab_id { association(:lab).id }
  
     
    end
  end