class User < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable, :omniauthable, omniauth_providers: [
      # :google_oauth2,
      (:developer unless Rails.env.production?)
    ].compact

  has_many :user_collections, dependent: :destroy
  has_many :collections, through: :user_collections

  def gravatar_url(size: 80)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end
end
