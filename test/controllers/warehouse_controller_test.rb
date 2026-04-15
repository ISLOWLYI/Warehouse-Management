require "test_helper"

class WarehouseControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get warehouse_info_url
    assert_response :success
  end
end
