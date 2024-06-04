class LabStaff < ApplicationRecord
  belongs_to :lab
  belongs_to :user, dependent: :destroy

  validates :department, presence: true
end
