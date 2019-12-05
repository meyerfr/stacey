class User < ApplicationRecord
  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

  validate :validate_array
  # validate :validate_prefered_suite
  # validate :validate_gender
  validates :first_name, :last_name, :email, :dob, :phone_number, :job, :move_in, :move_out, :amount_of_people, :gender, presence: true

  has_many :rooms, through: :bookings
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  def validate_array
    errors.add(:prefered_suite, 'Please choose at least one') if prefered_suite[0] == ""
    errors.add(:gender, 'Can´t be blank') if gender[0] == ""
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end

  def validate_prefered_suite
    errors.add(:prefered_suite) if prefered_suite[0] == ""
  end

  def validate_gender
    errors.add(:gender) if gender[0] == ""
  end
end
