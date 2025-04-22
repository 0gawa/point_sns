module DeviseAuthHelper
  def sign_in(user)
    post "http://localhost:3001/v1/auth/sign_in", params: { email: user.email, password: user.password }.to_json, headers: { 'Content-Type' => 'application/json', 'ACCEPT' => 'application/json' }
    auth_params = get_auth_params_from_login_response_headers(response)
  end

  private

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end
end
