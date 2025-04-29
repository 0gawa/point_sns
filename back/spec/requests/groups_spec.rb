require 'rails_helper'

RSpec.describe "Groupsコントローラーについて", type: :request do
  before(:each) do
    @user = create(:user)
    @auth_token = sign_in(@user)
  end

  describe "createアクションについて" do
    let(:params){ {group: {name: "test01", description: "test data", join_fee: 150, max_group_member: 100}} }
    
    context "グループを作成できる場合について" do
      before(:each) do
        @user.points_balance = 510
        @user.save
      end

      it "can just create a group" do
        post groups_path, params: params, headers: @auth_token
        expect(response.status).to eq(201)
        expect(Group.last.name).to eq("test01")
      end

      it "decrease user\'s points_balance by cost" do
        post groups_path, params: params, headers: @auth_token
        expect(response.status).to eq(201)
        expect(@user.points_balance).to eq(10)
      end

      it "join own group by default" do
        post groups_path, params: params, headers: @auth_token
        expect(response.status).to eq(201)
        expect(Group.last.users.first).to eq(@user)
      end
    end
    
    context "グループを作成できない場合について" do
      it "グループ作成に必要なポイントを保有していない：５００ポイント未満" do
        @user.points_balance = 499
        @user.save
        post groups_path, params: params, headers: @auth_token
        expect(response.status).to eq(422)
      end

      context "500ポイント以上所持しているが、無効なパラメーターの場合" do
        let!(:point) {500}
        before(:each) do
          @user.points_balance = point
          @user.save
        end
        # nameカラムが欠けている無効なパラメーター
        let(:params){ {group: {description: "test data", join_fee: 150, max_group_member: 100}} }
        
        it "グループが作成できない" do
          post groups_path, params: params, headers: @auth_token
          expect(response.status).to eq(422)
        end

        it "Do not decrease user\'s points_balance" do
          post groups_path, params: params, headers: @auth_token
          expect(@user.points_balance).to eq(point)
        end
      end
    end
  end

  describe "destroyアクションについて" do
    let!(:group) {create(:group, creator_user_id: @user.id)}

    it "グループの削除に成功するとき" do
      delete group_path(group.id), headers: @auth_token
      expect(Group.all.count).to eq(0)
      expect(response.status).to eq(200)
    end

    it "グループの削除に失敗するとき" do
      # 存在しないgroup_idを渡す
      delete group_path(id: 10), headers: @auth_token
      expect(Group.all.count).to eq(1)
      expect(response.status).to eq(422)
    end
  end
end
