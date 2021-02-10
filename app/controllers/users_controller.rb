class UsersController < ApplicationController
  before_action :baria_user, {only: [:edit, :update]}

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end

  def index
    @users = User.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def baria_user
    unless User.find(params[:id]).id.to_i == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
