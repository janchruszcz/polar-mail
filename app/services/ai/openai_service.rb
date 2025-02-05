class Ai::OpenaiService
  SYSTEM_PROMPT = <<~PROMPT.freeze
    You are an expert email writer specializing in cold outreach. Your task is to write highly effective cold emails that are:
    1. Personalized and relevant to the recipient
    2. Concise and respectful of the recipient's time
    3. Clear in their value proposition
    4. Professional and appropriate for business communication
    5. Focused on building genuine connections

    Format your response as follows:
    Subject: [Your subject line]

    [Email body]

    Always follow these principles:
    - Keep subject lines under 50 characters
    - Use a clear call-to-action
    - Avoid aggressive sales language
    - Match the specified tone and reading time
    - Include personalized details from recipient info
    - Focus on value to the recipient
  PROMPT

  def initialize
    @client = OpenAI::Client.new(access_token: OpenAiConfig.api_key)
  end

  def generate_email(purpose:, recipient_info:, sender_info:, parameters:)
    response = @client.chat(
      parameters: {
        model: OpenAiConfig.default_model,
        messages: [
          { role: "system", content: SYSTEM_PROMPT },
          { role: "user", content: generate_prompt(purpose, recipient_info, sender_info, parameters) }
        ],
        temperature: 0.7,
        max_tokens: calculate_max_tokens(parameters),
        presence_penalty: 0.1,
        frequency_penalty: 0.1
      }
    )

    parse_response(response)
  end

  private

  def generate_prompt(purpose, recipient_info, sender_info, parameters)
    <<~PROMPT
      Create a cold email with the following specifications:

      PURPOSE:
      #{purpose}

      RECIPIENT INFORMATION:
      #{recipient_info}

      SENDER INFORMATION:
      #{sender_info}

      EMAIL PARAMETERS:
      - Tone: #{parameters['tone'] || parameters[:tone]}
      - Target reading time: #{parameters['reading_time'] || parameters[:reading_time]}
      - Language: #{parameters['language'] || parameters[:language]}

      SPECIFIC REQUIREMENTS:
      1. Maintain a #{parameters['tone'] || parameters[:tone]} tone throughout
      2. Keep the email concise enough to read in #{parameters['reading_time'] || parameters[:reading_time]}
      3. Write in #{parameters['language'] || parameters[:language]}
      4. Include a clear, actionable next step
      5. Reference specific details about the recipient to show personalization
      6. Focus on value proposition rather than features
      7. Avoid generic openings like "I hope this email finds you well"

      Format as:
      Subject: [Compelling subject line under 50 characters]

      [Email body with appropriate greeting, content, and sign-off]
    PROMPT
  end

  def parse_response(response)
    return nil unless response["choices"]&.first&.dig("message", "content")

    content = response["choices"].first["message"]["content"]

    # Handle potential errors or unexpected formats
    if content.include?("Subject:") && content.include?("\n\n")
      content
    else
      format_fallback_response(content)
    end
  end

  def format_fallback_response(content)
    # If the response doesn't match expected format, attempt to structure it
    "Subject: Follow up regarding collaboration\n\n#{content}"
  end

  def calculate_max_tokens(parameters)
    # Adjust max tokens based on target reading time
    case parameters["reading_time"] || parameters[:reading_time]
    when /30 seconds/
      300
    when /1 minute/
      500
    when /2 minutes/
      800
    else
      500  # default to 1-minute length
    end
  end
end
