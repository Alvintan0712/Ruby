class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @role = case @user.role
            when 1
              'normal user'
            when 2
              'staff'
            when 3
              'admin'
            else
              'unknown'
            end
  end

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
      render 'edit'
    end
  end

  def show_balance
    @balance = current_user.balance
  end

  def recharge
    @user = current_user
    value = params[:value].to_f

    if value.is_a?(Float) and value.positive?
      @user.balance += value
    else
      render 'top_up'
    end

    if @user.save
      redirect_to users_show_balance_path
    else
      render 'top_up'
    end
  end

  def top_up
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
