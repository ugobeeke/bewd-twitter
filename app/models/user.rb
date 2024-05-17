class User < ApplicationRecord
    has_many :sessions
    has_many :tweets
  
    # Validations
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 64 }
    validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 500 }
    validates :password, presence: true, length: { minimum: 8, maximum: 64 }
  
    # Use `has_secure_password` for password handling
    has_secure_password
    
    has_many :sessions
  end
  