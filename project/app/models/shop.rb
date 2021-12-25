class Shop < ApplicationRecord
  validates :user_id, uniqueness: true
  validates :name, presence: true

  belongs_to :user
  has_many :products, dependent: :destroy

end
