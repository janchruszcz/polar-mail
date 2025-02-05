require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get emails_url
    assert_response :success
  end

  test "should get new" do
    get new_email_url
    assert_response :success
  end

  test "should create email" do
    assert_difference("Email.count") do
      post emails_url, params: {
        email: {
          purpose: "Test purpose",
          recipient_info: "Test recipient",
          sender_info: "Test sender",
          parameters: { tone: "professional" }
        }
      }
    end

    assert_redirected_to email_url(Email.last)
  end

  test "should show email" do
    email = emails(:valid_email)
    get email_url(email)
    assert_response :success
  end
end
