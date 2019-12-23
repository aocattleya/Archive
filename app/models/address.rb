class Address < ApplicationRecord
  validates :postal_code, presence: true, format: { with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}\z/}
  validates :prefecture, presence: true
  validates :city, presence: true
  validates :street, presence: true
  belongs_to :user
end
