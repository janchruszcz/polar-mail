require "test_helper"

class Ai::OpenaiServiceTest < ActiveSupport::TestCase
  def setup
    @service = Ai::OpenaiService.new
    @params = {
      purpose: "Business proposal",
      recipient_info: "John Doe, CEO",
      sender_info: "Jane Smith, Sales",
      parameters: { tone: "professional" }
    }
  end

  test "generates email content successfully" do
    OpenAI::Client.any_instance.expects(:chat).returns({
      "choices" => [
        {
          "message" => {
            "content" => "Subject: Business Proposal\n\nDear Mr. Doe,\n\nContent here..."
          }
        }
      ]
    })

    result = @service.generate_email(**@params)

    assert_match(/Subject:.+/, result)
    assert_match(/Dear Mr. Doe,/, result)
  end

  test "handles API errors gracefully" do
    OpenAI::Client.any_instance.expects(:chat).raises(OpenAI::Error)

    assert_raises(OpenAI::Error) do
      @service.generate_email(**@params)
    end
  end
end
