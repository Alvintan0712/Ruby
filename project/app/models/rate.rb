class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :review, presence: true
end
