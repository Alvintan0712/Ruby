class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to root_path
    else
      print("change failed\n")
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
