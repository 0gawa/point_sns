require 'rails_helper'

RSpec.describe "PointTransactionsコントローラーについて", type: :request do
  before(:each) do
    @user = create(:user)
    @auth_token = sign_in(@user)
  end
  
  describe "ルーティングが存在する" do
    let(:params) { { point_transaction: { point_change: 10, transaction_type: :post_create, entity_type: "post", entity_id: 1 } } }

    it "headers have access-token" do
      expect(response.has_header?('access-token')).to eq(true)
    end

    it "createアクションに関して" do
      post point_transactions_path, params: params, headers: @auth_token
      expect(response.status).to eq(201)
    end
  end
  
  describe "ポイントが追加される場合" do
    let(:new_post) { create(:post, user: @user) }

    context "ポイントトランザクションが正しく作成される場合" do
      it "投稿に関してのポイント取得" do
        post point_transactions_path, params: {
          point_transaction: {
            point_change: 10,
            transaction_type: :post_create,
            entity_type: "post",
            entity_id: new_post.id
          }
        }, headers: @auth_token

        expect(response).to have_http_status(:created)
        expect(PointTransaction.last.point_change).to eq(10)
        expect(PointTransaction.last.transaction_type).to eq("post_create")
        expect(PointTransaction.last.entity_type).to eq("post")
        expect(PointTransaction.last.entity_id).to eq(new_post.id)
      end
    end

    context "ポイントトランザクションが正しく作成されない場合" do
      it "無効なポイントトランザクション" do
        post point_transactions_path, params: {
          point_transaction: {
            point_change: 4.5,
            transaction_type: :post_create,
            entity_type: "tweet",
            entity_id: new_post.id
          }
        }, headers: @auth_token

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
