class Lab < ApplicationRecord
    has_many :lab_staffs, dependent: :destroy
    has_many :orders, dependent: :destroy
    has_many :riders

    validatable :name, presence: true
    validatable :country_code, presence: true, length: {is: 2}
end
