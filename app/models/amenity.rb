class Amenity < ApplicationRecord
  belongs_to :room, :project, optional: true
  has_one :icon, optional: true
end
