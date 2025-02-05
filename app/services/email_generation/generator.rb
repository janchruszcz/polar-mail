class EmailGeneration::Generator
  def initialize(purpose:, recipient_info:, sender_info:, parameters:)
    @purpose = purpose
    @recipient_info = recipient_info
    @sender_info = sender_info
    @parameters = parameters
  end

  def generate
    ai_response = Ai::OpenaiService.new.generate_email(
      purpose: @purpose,
      recipient_info: @recipient_info,
      sender_info: @sender_info,
      parameters: @parameters
    )

    parse_ai_response(ai_response)
  end

  private

  def parse_ai_response(response)
    return { subject: nil, content: nil } unless response

    subject = extract_subject(response)
    content = extract_content(response)

    {
      subject: subject || generate_fallback_subject,
      content: content || response
    }
  end

  def extract_subject(response)
    subject_line = response.split("\n").find { |line| line.start_with?("Subject:") }
    subject_line&.gsub("Subject:", "")&.strip
  end

  def extract_content(response)
    parts = response.split("\n\n")
    return response unless parts.length > 1

    parts[1..].join("\n\n")
  end

  def generate_fallback_subject
    "Follow up regarding #{@purpose.downcase.truncate(30)}"
  end
end
