class DropOldProducts < ActiveRecord::Migration[8.1]
  def up
    drop_table :products, if_exists: true
  end

  def down
    create_table :products do |t|
      t.string :category, null: false
      t.decimal :compare_at_price, precision: 10, scale: 2
      t.text :description
      t.string :gender, default: "all", null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :sizes, default: [], null: false, array: true
      t.timestamps
    end
  end
end
