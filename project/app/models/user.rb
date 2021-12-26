class User < ApplicationRecord
  # Include default users modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  attr_accessor :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # balance
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # Orders
  has_many :orders, dependent: :nullify

  # Shop
  has_one :shop, dependent: :destroy

  # Followship
  has_many :followships, dependent: :destroy

  # Favourite
  has_many :favourites, dependent: :destroy

  # Favourite
  has_many :rates, dependent: :nullify
end
