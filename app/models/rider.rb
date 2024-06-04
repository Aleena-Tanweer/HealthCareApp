class Rider < ApplicationRecord
  belongs_to :lab
  belongs_to :user, dependent: :destroy

  validates :vehicle_type, presence: true
  validates :area_of_coverage, presence: true
end
