class User < ApplicationRecord
  include BCrypt

  has_secure_password

  has_many :wishlists, dependent: :destroy
  has_many :items, dependent: :destroy

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8, maximum: 72 }, if: :password_required?

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  private

  def password_required?
    password_digest.nil? || password.present?
  end
end
