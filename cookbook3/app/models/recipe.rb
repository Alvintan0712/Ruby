class Recipe < ApplicationRecord
    belongs_to :category, optional: true
end
