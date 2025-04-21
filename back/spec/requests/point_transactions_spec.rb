require 'rails_helper'

RSpec.describe "PointTransactionsコントローラーについて", type: :request do
  
  describe "ルーティングが存在する" do
    let(:user) { create(:user) }
    let(:auth_token) { sign_in(user) }

    it "createアクションに関して" do
      post point_transactions_path, headers: auth_token
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "ポイントが追加される場合" do
    context "ポイントトランザクションが正しく作成される場合" do
      let(:user) { create(:user) }
      let(:new_post) { create(:post, user: user) }
      let(:auth_token) { sign_in(user) }

      it "投稿に関してのポイント取得" do
        post point_transactions_path, params: {
          point_transaction: {
            point_change: 10,
            transaction_type: :post_create,
            entity_type: "post",
            entity_id: new_post.id
          }
        }, headers: auth_token

        expect(response).to have_http_status(:created)
        expect(PointTransaction.last.point_change).to eq(10)
        expect(PointTransaction.last.transaction_type).to eq("post_create")
        expect(PointTransaction.last.entity_type).to eq("post")
        expect(PointTransaction.last.entity_id).to eq(new_post.id)
      end
    end

    context "ポイントトランザクションが正しく作成されない場合" do
    end
  end
end
