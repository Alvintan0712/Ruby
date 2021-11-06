class Blog < ApplicationRecord
    validates :title, :content, presence: true

    has_many :comments, dependent: :destroy
    belongs_to :user
end
