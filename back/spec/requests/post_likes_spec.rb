require 'rails_helper'

RSpec.describe "PostLikesコントローラーに関して", type: :request do
  before(:each) do
    @user = create(:user)
    @auth_token = sign_in(@user)
  end

  context "about user login" do
    it "headers have access-token" do
      expect(response.has_header?('access-token')).to eq(true)
    end
  end

  context "createアクションについて" do
    # post変数を作成すると、http methodのpostと重複するため、new_postとする
    let(:new_post) { create(:post, user: @user) }

    it "正しく処理される：いいねに成功する" do
      post post_post_likes_path(post_id: new_post.id), headers: @auth_token
      expect(response).to have_http_status(:created)
    end

    it "正しく処理されない：いいねに失敗する" do
      post post_post_likes_path(post_id: "post_id"), headers: @auth_token
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
