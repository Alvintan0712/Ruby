class Item < ApplicationRecord
  belongs_to :product
  has_many :order_items, dependent: :destroy

  validates :sale, :cost, :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :sale, :cost, :stock, :properties, presence: true
end
