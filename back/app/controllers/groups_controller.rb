class GroupsController < ApplicationController
  include Points::PayForCreatingGroupService
  include CanCreateGroupService
  before_action :authenticate_v1_user!

  def create
    unless CanCreateGroupService.new(current_v1_user).call
      render json: {error: "Not enough points available."}, status: :unprocessable_entity
    end

    @group = Group.new(group_params)
    @group.creator_user_id = current_v1_user.id
    if @group.save
      Points::PayForCreatingGroupService.new(current_v1_user, @group).call
      join_my_group(@group)
      render json: @group, status: :created
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

  def join_my_group(group)
    member = GroupMember.new(user_id: current_v1_user, group_id: group.id, role: :admin)
    member.save
  end
end
