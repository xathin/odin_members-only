class User < ApplicationRecord
  before_create :create_remember_token
  attr_accessor :remember

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
  validates :password, :password_confirmation, length: { minimum: 6 }
  has_secure_password
  has_many :posts

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string)
  end

  def new_remember_token
    self.remember = User.new_token
    update_attribute(:remember_token, User.digest(remember))
  end

  def authenticated?(token)
    User.digest(token) == :remember_token
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  private

  def create_remember_token
    self.remember = User.new_token
    self.remember_token = User.digest(remember)
  end
end
