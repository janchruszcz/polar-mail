require "test_helper"

class Api::EmailsControllerTest < ActionDispatch::IntegrationTest
  test "should create email via API" do
    assert_difference("Email.count") do
      post api_emails_url, params: {
        email: {
          purpose: "Test purpose",
          recipient_info: "Test recipient",
          sender_info: "Test sender",
          parameters: { tone: "professional" }
        }
      }, as: :json
    end

    assert_response :created
  end
end
