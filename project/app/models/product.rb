class Product < ApplicationRecord
  belongs_to :shop
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :nullify
end
