class BlogcommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    @blogcomment = Blogcomment.new(blogcomment_params)
    @blogcomment.user_id = current_user.id
    @blogcomment.blog_id = @blog.id
    @blogcomment.save
    redirect_to blog_path(params[:blog_id])
  end

  def destroy
    Blogcomment.find_by(id: params[:id], blog_id: params[:blog_id]).destroy
    redirect_to blog_path(params[:blog_id])
  end

  private

  def blogcomment_params
    params.require(:blogcomment).permit(:comment)
  end

end
