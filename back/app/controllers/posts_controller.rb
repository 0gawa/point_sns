class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destory]

  def new
  end

  def show
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { message: 'Post deleted successfully' }, status: :ok
    else
      render json: { errors: 'Post wasn\'t deleted successfully' }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content_text, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
