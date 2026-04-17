class AddInvitationTokenToWarehouseUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :warehouse_users, :invitation_token, :string
    add_index :warehouse_users, :invitation_token, unique: true
  end
end
