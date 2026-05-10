# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Example:
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Demo data for development
if Rails.env.development?
  # Create admin user
  admin = User.find_or_create_by!(email: "admin@warehouse.ru") do |u|
    u.password = "password123"
    u.password_confirmation = "password123"
    u.name = "Администратор"
    u.role = :admin
  end

  # Create warehouse
  warehouse = Warehouse.find_or_create_by!(name: "Главный склад") do |w|
    w.owner_name = admin.name
    w.address = "г. Москва, ул. Складская, 10"
    w.area = 500.0
    w.racks_count = 8
    w.zones_count = 4
  end

  # Link admin to warehouse
  WarehouseUser.find_or_create_by!(user: admin, warehouse: warehouse) do |wu|
    wu.role = :admin
    wu.active = true
  end

  # Create products
  products_data = [
    { sku: "SKU-001", name: "Ноутбук Dell XPS 13", category: "Электроника", quantity: 25, location: "1/2/3", status: :active },
    { sku: "SKU-002", name: "Монитор Samsung 27\"", category: "Электроника", quantity: 12, location: "1/3/1", status: :active },
    { sku: "SKU-003", name: "Клавиатура Logitech MX", category: "Периферия", quantity: 40, location: "2/1/5", status: :active },
    { sku: "SKU-004", name: "Мышь Logitech MX Master", category: "Периферия", quantity: 35, location: "2/1/6", status: :active },
    { sku: "SKU-005", name: "Кабель USB-C 2м", category: "Аксессуары", quantity: 100, location: "3/4/2", status: :active },
    { sku: "SKU-006", name: "Док-станция Dell", category: "Аксессуары", quantity: 8, location: "1/2/4", status: :inactive },
  ]

  products_data.each do |data|
    Product.find_or_create_by!(sku: data[:sku]) do |p|
      p.assign_attributes(data.merge(warehouse: warehouse))
    end
  end

  puts "Seed data created successfully!"
  puts "Admin: admin@warehouse.ru / password123"
end
