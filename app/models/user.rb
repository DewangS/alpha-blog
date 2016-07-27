class User < ActiveRecord::Base
  VALID_EMAIL_REGX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :username, presence: true, 
            uniqueness: { case_sensitive: false }, 
            length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: {maximum: 105}, 
            uniqueness: { case_sensitive: false}, 
            format: { with: VALID_EMAIL_REGX}
end