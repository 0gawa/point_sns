require 'rails_helper'

RSpec.describe "PointTransactionモデルについて", type: :model do
  describe 'アソシエーションの確認' do
    context "userモデルとの関連" do
      it "N:1の関連付けになっていること" do
        expect(PointTransaction.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
  
  describe "バリデーションの確認" do
    let(:user) { create(:user) }
    let(:point_transaction) { create(:point_transaction, user: user) }

    subject { point_transaction.valid? }

    context "point_changeは整数値であること" do
      it "小数のときx：切り捨てられていない小数" do
        point_transaction.point_change = 1.5
        is_expected.to eq false
      end
      it "整数のとき○" do
        point_transaction.point_change = 1
        is_expected.to eq true
      end
      it "nilのときX" do
        point_transaction.point_change = nil
        is_expected.to eq false
      end
    end

    context "descriptionは500文字以内であること" do
      it "500文字のとき○" do
        point_transaction.description = "a" * 500
        is_expected.to eq true
      end
      it "501文字のときX" do
        point_transaction.description = "a" * 501
        is_expected.to eq false
      end
    end
  end
end
