require 'rails_helper'

RSpec.describe "PostLikesコントローラーに関して", type: :request do
  context "いいねすることについて" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it "リクエストが成功すること" do
      get post_likes_path
      expect(response).to have_http_status(:success)
    end
  end
end
