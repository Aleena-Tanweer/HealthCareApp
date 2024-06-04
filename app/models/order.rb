class Order < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor
  belongs_to :lab
  has_many :tests, dependent: :destroy

  validates :patient_id, presence: true
  validates :doctor_id, presence: true
  validates :order_date, presence: true
  validates :status, presence: true
  validates :order_barcode, presence: true, uniqueness: true

  before_validation :generate_barcode_id, on: :create
  before_validation :set_date_of_order, on: :create
  before_validation :set_default_status, on: :create

  enum status: {
    placed: 'placed',
    sample_collected: 'sample_collected',
    in_transit: 'in_transit',
    received: 'received',
    completed: 'completed'
  }


  def generate_barcode_id
    lab_country_code = @order.lab.country_code
    current_year = Date.today.year.to_s.last(2)
    
    last_order = Order.where("barcode_id LIKE ?", "#{current_year}-#{lab_country_code}%").order("order_barcode DESC").first
    
    if last_order
      last_serial_number = last_order.order_barcode.split('-').last
      last_serial_number_letter = last_serial_number[0]
      last_serial_number_digits = last_serial_number[1..].to_i
  
      if last_serial_number_digits == 99_999
        next_serial_number_letter = last_serial_number_letter.next
        next_serial_number_digits = 1
      else
        next_serial_number_letter = last_serial_number_letter
        next_serial_number_digits = last_serial_number_digits + 1
      end
    else
      next_serial_number_letter = 'A'
      next_serial_number_digits = 1
    end
    
    "#{current_year}-#{lab_country_code}#{next_serial_number_letter}#{'%05d' % next_serial_number_digits}"
  end

  def set_date_of_order
    self.order_date ||= Time.current
  end

  def set_default_status
    self.status ||= 'placed'
  end

end
