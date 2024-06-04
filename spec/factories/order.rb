FactoryBot.define do
    factory :order do
      doctor_id { association(:doctor).id }
      patient_id { association(:patient).id }
      order_date { Faker::Date.between(from: 1.year.ago, to: Date.today) }
      status { 'placed' }
      order_barcode { '24MY-A00001'}
  
      
    end
  end