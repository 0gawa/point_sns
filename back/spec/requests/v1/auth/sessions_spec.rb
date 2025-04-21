# spec/requests/auth/sessions_spec.rb
require 'rails_helper'

RSpec.describe 'POST /auth/sign_in', type: :request do
  let!(:user) { create(:user, password: 'password123', password_confirmation: 'password123') }
  let(:sign_in_url) { '/v1/auth/sign_in' }

  def json_body
    JSON.parse(response.body)
  end

  context '有効な認証情報の場合' do
    let(:params) do
      {
        email: user.email,
        password: 'password123'
      }
    end

    before do
      post sign_in_url, params: params, as: :json
    end

    it 'ステータスコード200 (OK) が返されること' do
      expect(response).to have_http_status(:ok)
    end

    it 'レスポンスヘッダーに認証トークンが含まれること' do
      expect(response.headers['access-token']).to be_present
      expect(response.headers['client']).to be_present
      expect(response.headers['uid']).to eq(user.email)
      expect(response.headers['expiry']).to be_present
      expect(response.headers['token-type']).to eq('Bearer')
    end

    it 'レスポンスボディにユーザーデータが含まれること' do
      expect(json_body['data']['id']).to eq(user.id)
      expect(json_body['data']['email']).to eq(user.email)
    end
  end

  context '無効な認証情報 (間違ったパスワード) の場合' do
    let(:params) do
      {
        email: user.email,
        password: 'wrongpassword'
      }
    end

    before do
      post sign_in_url, params: params, as: :json
    end

    it 'ステータスコード401 (Unauthorized) が返されること' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'レスポンスヘッダーに認証トークンが含まれないこと' do
      expect(response.headers['access-token']).to be_blank
      expect(response.headers['client']).to be_blank
      expect(response.headers['uid']).to be_blank
    end

    it 'レスポンスボディにエラーメッセージが含まれること' do
      expected_error_message = I18n.t('devise_token_auth.sessions.bad_credentials')
      expect(json_body['errors']).to include(expected_error_message)
    end
  end

  context '無効な認証情報 (存在しないメールアドレス) の場合' do
    let(:params) do
      {
        email: 'nonexistent@example.com',
        password: 'password123'
      }
    end

    before do
      post sign_in_url, params: params, as: :json
    end

    it 'ステータスコード401 (Unauthorized) が返されること' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'レスポンスボディにエラーメッセージが含まれること' do
      expected_error_message = I18n.t('devise_token_auth.sessions.bad_credentials')
      expect(json_body['errors']).to include(expected_error_message)
    end
  end
end
