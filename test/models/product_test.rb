require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product should be valid" do
    product = products(:one)
    assert product.valid?
  end

  test "product should require sku" do
    product = Product.new(name: "Test", category: "Test", quantity: 1, warehouse: warehouses(:one))
    assert_not product.valid?
  end

  test "product location should match format" do
    product = products(:one)
    product.location = "invalid"
    assert_not product.valid?
  end

  test "product quantity should not be negative" do
    product = products(:one)
    product.quantity = -1
    assert_not product.valid?
  end
end
