class Image < ApplicationRecord
  belongs_to :item, optional: true
end
