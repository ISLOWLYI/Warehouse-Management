class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :warehouse_users, dependent: :destroy
  has_many :warehouses, through: :warehouse_users

  enum :role, { admin: 0, worker: 1, supplier: 2 }

  validates :role, presence: true

  def admin?
    role == "admin"
  end

  def worker?
    role == "worker"
  end

  def supplier?
    role == "supplier"
  end
end
