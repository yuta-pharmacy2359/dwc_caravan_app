class BlogcommentsController < ApplicationController
  before_action :baria_user, {only: [:destroy]}

  def create
    @blog = Blog.find(params[:blog_id])
    @blogcomment = Blogcomment.new(blogcomment_params)
    @blogcomment.user_id = current_user.id
    @blogcomment.blog_id = @blog.id
    @blogcomment.save
  end

  def destroy
    @blogcomment = Blogcomment.find_by(id: params[:id], blog_id: params[:blog_id])
    @blogcomment.destroy
    @blog = @blogcomment.blog
  end

  private

  def blogcomment_params
    params.require(:blogcomment).permit(:comment)
  end

  def baria_user
    unless Blogcomment.find(params[:id]).user.id.to_i == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
