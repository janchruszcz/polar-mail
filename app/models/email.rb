class Email < ApplicationRecord
  has_one :email_history
  
  # validates :purpose, :recipient_info, :sender_info, presence: true
  # validates :parameters, presence: true, json: true

  def generate_content
    result = EmailGeneration::Generator.new(
      purpose: purpose,
      recipient_info: recipient_info,
      sender_info: sender_info,
      parameters: parameters
    ).generate

    update(
      subject: result[:subject],
      content: result[:content]
    )

    create_email_history!(generated_at: Time.current)
  end
end
