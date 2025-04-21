class V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :sign_up_params, only: [:create]

  wrap_parameters false
  
  private

  def sign_up_params
    params.permit(:name, :nickname, :email, :password, :password_confirmation)
  end
end
