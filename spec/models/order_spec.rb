ruby
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:patient_id) }
    it { should validate_presence_of(:doctor_id) }
    it { should validate_presence_of(:order_date) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:order_barcode) }
    it { should validate_uniqueness_of(:order_barcode) }
  end

  describe 'associations' do
    it { should belong_to(:patient) }
    it { should belong_to(:doctor) }
    it { should belong_to(:lab) }
    it { should have_many(:tests).dependent(:destroy) }
  end

  describe 'callbacks' do
    it 'sets default status before validation' do
      order = create(:order)
      expect(order.status).to eq('placed')
    end

    it 'sets order date before validation' do
      order = create(:order)
      expect(order.order_date).not_to be_nil
    end

    it 'generates barcode id before validation' do
      order = create(:order)
      expect(order.order_barcode).not_to be_nil
    end
  end

  describe 'status enum' do
    it 'defines the correct status enum values' do
      expect(Order.statuses.keys).to match_array(['placed', 'sample_collected', 'in_transit', 'received', 'completed'])
    end
  end
end