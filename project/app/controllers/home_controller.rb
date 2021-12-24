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
end
