class Test < ApplicationRecord
  belongs_to :order
  mount_uploader :result_document, ResultUploader

  validates :name, presence: true
  validates :description, presence: true
  validates :fasting_required, inclusion: { in: [true, false] }
  validates :status, presence: true
  validates :result_document, presence: true

  enum status: {
    ordered: 'ordered',
    in_progress: 'in_progress',
    completed: 'completed'
  }

  before_validation :set_default_status, on: :create

  private

  def set_default_status
    self.status ||= 'ordered'
  end
end
