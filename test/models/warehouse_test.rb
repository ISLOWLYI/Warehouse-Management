require "test_helper"

class WarehouseTest < ActiveSupport::TestCase
  test "warehouse should be valid" do
    warehouse = warehouses(:one)
    assert warehouse.valid?
  end

  test "warehouse should require name" do
    warehouse = Warehouse.new(owner_name: "Test", racks_count: 1, zones_count: 1)
    assert_not warehouse.valid?
  end

  test "warehouse should require non-negative racks_count" do
    warehouse = Warehouse.new(name: "Test", owner_name: "Test", racks_count: -1, zones_count: 1)
    assert_not warehouse.valid?
  end
end
