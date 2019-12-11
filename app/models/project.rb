class Project < ApplicationRecord
  mount_uploaders :pictures, PictureUploader
  has_many :amenities
end
