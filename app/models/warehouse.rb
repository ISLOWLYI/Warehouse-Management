class Warehouse < ApplicationRecord
  has_many :warehouse_users, dependent: :destroy
  has_many :users, through: :warehouse_users
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :owner_name, presence: true
  validates :racks_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :zones_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
