class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable,:otp_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_one :doctor, dependent: :destroy
  has_one :patient, dependent: :destroy
  has_one :lab_staff, dependent: :destroy
  has_one :rider, dependent: :destroy

  enum role: { doctor: 0, patient: 1, lab_staff: 2, rider: 3 }

  validates :name, presence: true
  validates :role, presence: true
       
  def jwt_payload
    super
  end

  


end
