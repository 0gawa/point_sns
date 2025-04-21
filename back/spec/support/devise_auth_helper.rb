module DeviseAuthHelper
  def sign_in(user)
    post v1_user_session_path, params: { email: user.email, password: user.password }
    response.headers.slice('client', 'uid', 'token-type', 'access-token')
  end
end
