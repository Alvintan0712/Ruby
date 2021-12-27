class HomeController < ApplicationController
  before_action :authenticate_user!, only: %i[ index ]

  def index
    @shops = if Shop.exists?(user: current_user)
               Shop.where.not(user: current_user)
             else
               Shop.all
             end
  end

  def about; end

  def search
    @products = Product.where('name LIKE ?', "%#{params[:query]}%")
    @shops = Shop.where('name LIKE ?', "%#{params[:query]}%")
  end
end
