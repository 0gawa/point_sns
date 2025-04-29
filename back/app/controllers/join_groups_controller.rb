class JoinGroupsController < ApplicationController
  before_action :authenticate_v1_user!

  def create
    member = GroupMember.new(group_member_params)
    member.user_id = current_v1_user.id
    group = set_group(member.group_id)

    unless Points::CanJoinGroupService.new(current_v1_user, group.join_fee)
      render json: {error: "Not enough points available."}, status: :unprocessable_entity
      return
    end

    if member.save
      Points::PayForJoiningGroupService.new(current_v1_user, group).call
      render json: member, status: :created
    else
      render json: member.errors, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def group_member_params
    params.require(:group_member).permit(:group_id)
  end

  def set_group(group_id)
    unless Group.find(group_id)
      render json: {error: "Not found group_id: #{group_id}"}, status: :unprocessable_entity
      return
    end
  end
end
