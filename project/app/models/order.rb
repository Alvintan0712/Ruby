class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :order_items, dependent: :destroy

  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true
end
