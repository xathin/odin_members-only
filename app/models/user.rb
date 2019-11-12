class User < ApplicationRecord
  before_create :create_remember_token
  attr_accessor :remember

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, :password_confirmation, length: { minimum: 6 }
  has_secure_password

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def create_remember_token
    self.remember = new_token
    update_attribute(:remember_token, digest(remember))
  end
end
