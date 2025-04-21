require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe 'アソシエーションの確認' do
    context "postモデルとの関連" do
      it "1:Nの関連付けになっていること" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context "post_likeモデルとの関連" do
      it "1:Nの関連付けになっていること" do
        expect(User.reflect_on_association(:post_likes).macro).to eq :has_many
      end
    end
    context "point_transactionモデルとの関連" do
      it "1:Nの関連付けになっていること" do
        expect(User.reflect_on_association(:point_transactions).macro).to eq :has_many
      end
    end
  end
end
