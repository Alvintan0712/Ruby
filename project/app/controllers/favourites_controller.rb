class FavouritesController < ApplicationController
  def index
    @favourites = Favourite.where(user: current_user)
  end

  def create
    favourite = Favourite.new(user: current_user, product_id: params[:product_id])
    favourite.save
    redirect_back fallback_location: favourites_path, notice: 'Add successfully'
  end

  def destroy
    favourite = Favourite.find_by(user: current_user, product_id: params[:product_id])
    favourite.destroy
    redirect_back fallback_location: favourites_path, notice: 'Remove successfully'
  end
end
