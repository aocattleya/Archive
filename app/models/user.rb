class User < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google, :facebook]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.from_omniauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.nickname = auth.info.name
      user.email = auth.info.email
    end
  end
end
