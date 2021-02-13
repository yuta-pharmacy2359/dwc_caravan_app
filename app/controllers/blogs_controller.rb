class BlogsController < ApplicationController
  before_action :baria_user, {only: [:edit, :update, :destroy]}

  def index
    @blogs = Blog.page(params[:page]).reverse_order
  end

  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blog_path(@blog.id)
    else
      render :new
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blog_path(blog)
    else
      render :edit
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to blogs_path
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :category, :body, :image)
  end

  def baria_user
    unless Blog.find(params[:id]).user.id.to_i == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
