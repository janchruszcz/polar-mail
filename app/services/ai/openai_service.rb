class Ai::OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
  end

  def generate_email(purpose:, recipient_info:, sender_info:, parameters:)
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { 
            role: "system", 
            content: "You are an expert email writer. Generate professional cold emails that are concise and effective."
          },
          {
            role: "user",
            content: generate_prompt(purpose, recipient_info, sender_info, parameters)
          }
        ],
        temperature: 0.7
      }
    )

    parse_response(response)
  end

  private

  def generate_prompt(purpose, recipient_info, sender_info, parameters)
    "Generate a cold email with:\nPurpose: #{purpose}\nRecipient: #{recipient_info}\nSender: #{sender_info}\nParameters: #{parameters}"
  end

  def parse_response(response)
    response.dig("choices", 0, "message", "content")
  end
end
