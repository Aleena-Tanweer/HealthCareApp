require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date_of_birth) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:contact_number) }
    it { should validate_presence_of(:fasting_requirements) }
  end

  describe 'associations' do
    it { should belong_to(:user).dependent(:destroy) }
    it { should have_many(:orders) }
  end
end