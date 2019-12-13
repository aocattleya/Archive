class Image < ApplicationRecord
  belongs_to :item, optional: true
  mount_uploaders :image, ImageUploader
end
