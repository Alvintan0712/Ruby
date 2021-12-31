class Product < ApplicationRecord
  belongs_to :shop
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, :description, :specification, presence: true
end
