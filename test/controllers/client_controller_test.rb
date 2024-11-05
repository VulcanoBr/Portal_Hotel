require "test_helper"

class ClientControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get client_welcome_url
    assert_response :success
  end
end
