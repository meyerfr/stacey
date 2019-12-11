class Room < ApplicationRecord
  belongs_to :project
  has_many :users, through: :bookings
  has_many :amenities
end
