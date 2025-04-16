class PostsController < ApplicationController
  def new
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:content_text, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
