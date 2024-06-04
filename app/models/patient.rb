class Patient < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :orders

  validates :date_of_birth, presence: true
  validates :address, presence: true
  validates :contact_number, presence: true
  validates :fasting_requirements, presence: true
end
