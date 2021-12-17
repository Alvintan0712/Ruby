class UsersController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_with_password(user_params)
        sign_in @user, bypass: true
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # def update
  #   @user = current_user
  #   print("user_params:")
  #   print(params)
  #   print("\n")
  #   print("current password:")
  #   print(params[:current_password])
  #   print(@user.valid_password?(params[:current_password]))
  #   print("\n")
  #   if @user.update_with_password(user_params)
  #     # Sign in the user by passing validation in case their password changed
  #     bypass_sign_in(@user)
  #     redirect_to root_path
  #   else
  #     print("change failed\n")
  #     render "edit"
  #   end
  # end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
