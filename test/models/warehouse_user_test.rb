require "test_helper"

class WarehouseUserTest < ActiveSupport::TestCase
  test "warehouse_user should be valid" do
    wu = warehouse_users(:one)
    assert wu.valid?
  end

  test "warehouse_user should have a role" do
    wu = WarehouseUser.new(user: users(:two), warehouse: warehouses(:two), role: nil)
    assert_not wu.valid?
  end
end
