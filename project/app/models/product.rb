class Product < ApplicationRecord
  belongs_to :shop
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :nullify
  has_many :favourites, dependent: :nullify
  has_many :rates, dependent: :destroy
end
