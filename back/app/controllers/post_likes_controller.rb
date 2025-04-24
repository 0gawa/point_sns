class PostLikesController < ApplicationController
  before_action :set_post_like_from_current_user, only: [:destroy]
  before_action :authenticate_v1_user!, only: [:create, :destroy]

  def create
    @favorite = current_v1_user.post_likes.new(post_id: params[:post_id])
    if @favorite.save
      render json: { message: 'Like added successfully' }, status: :created
    else
      render json: { error: 'Unable to add like' }, status: :unprocessable_entity
    end
  end

  def destroy
    if @post_like #存在するかどうか
      @post_like.destroy
      render json: { message: 'Like removed successfully' }, status: :ok
    else
      render json: { error: 'Like not found' }, status: :not_found
    end
  end

  private

  def set_post_like_from_current_user
    @post_like = current_v1_user.post_likes.find_by(post_id: params[:post_id])
  end
end
