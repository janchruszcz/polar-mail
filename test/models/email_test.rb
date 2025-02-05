require "test_helper"

class EmailTest < ActiveSupport::TestCase
  def setup
    @email = emails(:valid_email)
  end

  test "should generate content successfully" do
    @email.email_history&.destroy

    OpenAI::Client.any_instance.stubs(:chat).returns({
      "choices" => [
        {
          "message" => {
            "content" => "Subject: Test Subject\n\nTest content"
          }
        }
      ]
    })

    assert_difference -> { EmailHistory.count }, 1 do
      @email.generate_content
    end

    assert_not_nil @email.subject
    assert_not_nil @email.content
    assert @email.email_history.present?
  end
end
