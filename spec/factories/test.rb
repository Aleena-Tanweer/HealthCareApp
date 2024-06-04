# spec/factories/tests.rb
FactoryBot.define do
    factory :test do
      order_id { association(:order).id }
      name { Faker::Lorem.word }
      description { Faker::Lorem.sentence }
      fasting_required { Faker::Boolean.boolean }
      status { :ordered }
    
    end
  end