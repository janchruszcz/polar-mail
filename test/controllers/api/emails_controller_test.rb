require "test_helper"

class Api::EmailsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_emails_create_url
    assert_response :success
  end
end
