class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    print("user id is:")
    print(@user.id)
    print("\n")
  end
end
