class User < ApplicationRecord
  has_secure_password

  has_many :wishlists, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
end
