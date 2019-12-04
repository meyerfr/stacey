class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :contracts
end
