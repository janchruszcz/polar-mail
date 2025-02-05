class Email < ApplicationRecord
  has_one :email_history
  
  # validates :purpose, :recipient_info, :sender_info, presence: true
  # validates :parameters, presence: true, json: true
end
