require 'rails_helper'

RSpec.describe "Postモデルのテスト", type: :model do
  describe "アソシエーションのテスト" do
    context "userモデルとの関連" do
      it "N:1の関連付けになっていること" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end

  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    let(:post) { build(:post, user: user) }

    context "content_textカラム" do
      it "空欄はNG" do
        post.content_text = ""
        expect(post).not_to be_valid
      end

      it "300文字以下の場合は有効であること" do
        post.content_text = "a" * 300
        expect(post).to be_valid
      end

      it "301文字以上であること" do
        post.content_text = "a" * 301
        expect(post).not_to be_valid
      end
    end

  end
end
