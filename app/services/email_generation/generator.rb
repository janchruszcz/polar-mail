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

    {
      subject: extract_subject(ai_response),
      content: extract_content(ai_response)
    }
  end

  private

  def extract_subject(response)
    response.split("\n").find { |line| line.start_with?("Subject:") }&.gsub("Subject:", "")&.strip
  end

  def extract_content(response)
    response.split("\n")[2..].join("\n")
  end
end
