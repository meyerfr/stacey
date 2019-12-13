class Project < ApplicationRecord
  has_many :rooms
  has_many :amenities
end
