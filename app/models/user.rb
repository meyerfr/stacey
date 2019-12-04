class User < ApplicationRecord
  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

  validate :validate_prefered_suite
  validate :validate_gender
  validates :first_name, :last_name, :email, :dob, :phone_number, :job, :move_in, :move_out, :amount_of_people, :gender, presence: true

  has_many :rooms, through: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  private

  def password_required?
    return false if skip_password_validation

    super
  end

  def validate_prefered_suite
    errors.add(:prefered_suite, :invalid) if prefered_suite.empty?
  end

  def validate_gender
    errors.add(:gender, :invalid) if gender.empty?
  end
end
