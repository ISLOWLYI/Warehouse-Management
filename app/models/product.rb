class Product < ApplicationRecord
  self.primary_key = :sku

  belongs_to :warehouse

  enum :status, { active: 0, inactive: 1, archived: 2 }

  validates :sku, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :name, presence: true, length: { maximum: 255 }
  validates :category, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :location, format: { with: /\A\d+\/\d+\/\d+\z/, message: "must be in format zone/rack/spot" }, allow_blank: true
end
