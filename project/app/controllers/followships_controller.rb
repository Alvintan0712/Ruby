class FollowshipsController < ApplicationController
  def index
    @followships = Followship.where(user: current_user)
  end

  def create
    followship = Followship.new(user: current_user, shop_id: params[:shop_id])
    followship.save
    redirect_back fallback_location: followships_path, notice: 'Follow successfully'
  end

  def destroy
    followship = Followship.find_by(user: current_user, shop_id: params[:shop_id])
    followship.destroy
    redirect_back fallback_location: followships_path, notice: 'unFollow successfully'
  end
end
