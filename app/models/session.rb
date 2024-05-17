class Session < ApplicationRecord
    belongs_to :user
  
    # Validations
    validates :token, presence: true, uniqueness: true
    validates :user_id, presence: true
  
    # Callbacks
    before_validation :generate_session_token, on: :create
  
    private
  
    def generate_session_token
      self.token = SecureRandom.hex(20) if self.token.blank?
    end
  end
  