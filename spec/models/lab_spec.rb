require 'rails_helper'

RSpec.describe Lab, type: :model do
  describe 'associations' do
    it { should have_many(:lab_staffs).dependent(:destroy) }
    it { should have_many(:orders).dependent(:destroy) }
    it { should have_many(:riders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:country_code) }
    it { should validate_length_of(:country_code).is_equal_to(2) }
  end
end