class Doctor < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :orders

  validates :specialization, presence: true
  validates :clinic_name, presence: true
end
