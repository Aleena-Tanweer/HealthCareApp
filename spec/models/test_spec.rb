require 'rails_helper'

RSpec.describe Test, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_inclusion_of(:fasting_required).in_array([true, false]) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:result_document) }
  end

  describe 'associations' do
    it { should belong_to(:order) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(ordered: 'ordered', in_progress: 'in_progress', completed: 'completed') }
  end

  describe 'callbacks' do
    describe '#set_default_status' do
      let(:test) { create(:test, status: nil) }

      it 'sets the default status to ordered' do
        expect(test.status).to eq('ordered')
      end
    end
  end
end