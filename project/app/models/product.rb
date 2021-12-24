class Product < ApplicationRecord
    belongs_to :shop
    has_many :orders, dependent: :nullify

    # storage
    validates :storage, numericality: { greater_than_or_equal_to: 0 }
end
