class CreateProducts < ActiveRecord::Migration[8.1]
  def change
    create_table :products, id: false do |t|
      t.string :sku, null: false, primary_key: true
      t.references :warehouse, null: false, foreign_key: true
      t.string :name, null: false
      t.string :category, null: false
      t.integer :quantity, default: 0, null: false
      t.string :location
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
