class User < ActiveRecord::Base
  has_many :articles
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: {maximum: 105}, 
            uniqueness: { case_sensitive: false}, 
            format: { with: VALID_EMAIL_REGX}
  has_secure_password
end