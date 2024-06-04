require 'rails_helper'

RSpec.describe Rider, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:vehicle_type) }
    it { should validate_presence_of(:area_of_coverage) }
  end

  describe 'associations' do
    it { should belong_to(:lab) }
    it { should belong_to(:user).dependent(:destroy) }
  end
end