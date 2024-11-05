require "test_helper"

class RoomTypesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get room_types_index_url
    assert_response :success
  end
end
