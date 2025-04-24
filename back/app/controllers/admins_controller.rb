class AdminsController < ApplicationController
  before_action [:authenticate_v1_user!, :authenticate_admin]

  private

  def authenticate_admin
    unless current_v1_user.admin?
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
