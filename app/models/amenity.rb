class Amenity < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :project, optional: true
  has_many :icons
end
