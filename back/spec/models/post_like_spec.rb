require 'rails_helper'

RSpec.describe "PostLikeモデルについて", type: :model do
  describe 'アソシエーションの確認' do
    context "postモデルとの関連" do
      it "N:1の関連付けになっていること" do
        expect(PostLike.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
    context "userモデルとの関連" do
      it "N:1の関連付けになっていること" do
        expect(PostLike.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
