class JoinGroupsController < ApplicationController
  before_action :authenticate_v1_user!

  def create
    member = GroupMember.new(group_member_params)
    member.user_id = current_v1_user.id
    if member.save
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
end
