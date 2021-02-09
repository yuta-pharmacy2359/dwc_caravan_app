class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs
  end

  def edit
    @user = User.find(params[:id])
  end
end
