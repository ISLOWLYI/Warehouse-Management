class CreateWarehouses < ActiveRecord::Migration[8.1]
  def change
    create_table :warehouses do |t|
      t.string :name, null: false
      t.string :owner_name, null: false
      t.string :address
      t.decimal :area, precision: 10, scale: 2
      t.integer :racks_count, default: 0, null: false
      t.integer :zones_count, default: 0, null: false
      t.timestamps
    end
  end
end
