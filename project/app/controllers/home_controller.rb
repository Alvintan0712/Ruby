class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @products = Product.where.not(user_id: @user.id)
  end
end
