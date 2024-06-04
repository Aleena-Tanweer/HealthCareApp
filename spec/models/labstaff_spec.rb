require 'rails_helper'

RSpec.describe LabStaff, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:department) }
  end

  describe 'associations' do
    it { should belong_to(:lab) }
    it { should belong_to(:user).dependent(:destroy) }
  end
end
