require 'rails_helper'

RSpec.describe "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    context "content_textカラム" do
      it "空欄でも有効であること" do
        post.content_text = ""
        expect(post).to be_valid
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
