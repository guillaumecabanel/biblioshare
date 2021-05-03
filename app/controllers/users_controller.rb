class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_or_create_by(user_params)
    set_user(@user)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:full_name)
  end
end
