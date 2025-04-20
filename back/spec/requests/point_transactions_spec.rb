require 'rails_helper'

RSpec.describe "PointTransactionsコントローラーについて", type: :request do
  describe "ルーティングが存在する" do
    it "createアクションに関して" do
      post point_transactions_path
      expect(response).to have_http_status(:success)
    end
  end
end
