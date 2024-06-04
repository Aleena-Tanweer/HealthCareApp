require 'rails_helper'

RSpec.describe Doctor, type: :model do

   describe 'validations' do
    it { should validate_presence_of(:specialization) }
    it { should validate_presence_of(:clinic_name) }
  end

  describe 'associations' do
    it { should belong_to(:user).dependent(:destroy) }
    it { should have_many(:orders) }
  end

  describe 'factory' do
    it 'is valid' do
      doctor = FactoryBot.create(:doctor)
      expect(doctor).to be_valid
    end
  end
end
