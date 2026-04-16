class CreateWarehouseUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :warehouse_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :warehouse, null: false, foreign_key: true
      t.integer :role, default: 1, null: false
      t.boolean :active, default: true, null: false
      t.timestamps
    end

    add_index :warehouse_users, [:user_id, :warehouse_id], unique: true
  end
end
