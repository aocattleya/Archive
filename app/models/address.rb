class Address < ApplicationRecord
  validates :postal_code, presence: true
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true
  belongs_to :user
end
