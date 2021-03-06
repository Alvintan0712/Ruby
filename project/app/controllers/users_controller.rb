class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
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
      render 'edit'
    end
  end

  def show_balance
    @balance = current_user.balance
  end

  def recharge
    @user = current_user
    value = params[:value].to_f

    if value.is_a?(Float) && value.positive?
      @user.balance += value
    else
      render 'top_up'
      return
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

  def withdraw
    @user = current_user
  end

  def withdrawal
    @user = current_user
    value = params[:value].to_f

    if params['password'] != params['password_confirmation']
      redirect_back fallback_location: users_withdraw_path, notice: 'Your password and confirmation password must match'
      return
    elsif !@user.valid_password?(params[:password])
      redirect_back fallback_location: users_withdraw_path, alert: 'Password incorrect'
      return
    elsif value.is_a?(Float) && value.positive? && (value <= @user.balance)
      @user.balance -= value
    else
      redirect_back fallback_location: users_withdraw_path, notice: 'So Poor'
      return
    end

    if @user.save
      redirect_to users_show_balance_path
    else
      redirect_back fallback_location: users_withdraw_path, notice: 'So Poor'
    end
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
