require "test_helper"

class WarehousesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index when logged in" do
    sign_in users(:one)
    get warehouses_url
    assert_response :success
  end
end
