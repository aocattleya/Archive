class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google, :facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses
  has_many :trancacts
  has_many :cards

  validates :email,          presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password,       presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,40}+\z/i }
  validates :phonenumber,    presence: true, format: { with: /\A\d{10,11}\z/ }
  validates :birthday_year,  presence: true
  validates :birthday_month, presence: true
  validates :birthday_day,   presence: true
  def self.from_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.nickname = auth.info.name
      user.email = auth.info.email
    end
  end
end
