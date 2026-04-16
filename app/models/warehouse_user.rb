class WarehouseUser < ApplicationRecord
  belongs_to :user
  belongs_to :warehouse

  enum :role, { admin: 0, worker: 1, supplier: 2 }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :warehouse_id, message: "already member of this warehouse" }
end
