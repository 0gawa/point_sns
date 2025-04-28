class GroupsController < ApplicationController
  before_action :authenticate_v1_user!
  include Points::PayForCreatingGroupService

  def create
    @group = Group.new(group_params)
    @group.creator_user_id = current_v1_user.id
    if @group.save
      Points::PayForCreatingGroupService.new(current_v1_user, @group).call
      render json: @group, status: :craeted
    else
      render json: { error: @group.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      render json: { 'Group deleted successfully' }, status: :ok
    else
      render json: { 'Group wasn\'t deleted successfully' }, status: :unprocessable_entity
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :join_fee, :max_group_member)
  end
end
