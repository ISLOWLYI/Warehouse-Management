require "test_helper"

class WarehouseControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should redirect root when logged in" do
    sign_in users(:one)
    get root_url
    assert_response :success
  end
end
