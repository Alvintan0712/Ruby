class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  validates :quantity, :cost, presence: true
end
