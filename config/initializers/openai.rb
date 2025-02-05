module OpenAiConfig
  def self.api_key
    ENV.fetch("OPENAI_API_KEY") do
      raise "OPENAI_API_KEY is not set. Please set it in your environment variables."
    end
  end

  def self.default_model
    ENV.fetch("OPENAI_MODEL", "gpt-3.5-turbo")
  end
end
