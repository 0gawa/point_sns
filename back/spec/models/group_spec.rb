require 'rails_helper'

RSpec.describe "Groupモデルについて", type: :model do
  describe "About association" do
  end

  describe "About validation" do
    let(:user)  { create(:user) }
    let(:group) { create(:group, creator_user_id: user.id) }
    
    subject { group.valid? }

    context "Not null restriction" do
      it "of name" do
        group.name = ""
        is_expected.to eq false
      end
      it "of description" do
        group.description = ""
        is_expected.to eq true
      end
      it "of creator_user_id" do
        group.creator_user_id = nil
        is_expected.to eq false
      end
    end

    context "Value restriction" do
      it "length of name is greater than 50: false" do
        group.name = "a" * 51
        is_expected.to eq false
      end
      it "length of name is equal ot less than 50" do
        group.name = "a" * 50
        is_expected.to eq true
        group.name = "a" * 49
        is_expected.to eq true
      end
      it "length of description is greater than 300: false" do
        group.description = "a" * 301
        is_expected.to eq false
      end
      it "length of description is equal or less than 300" do
        group.description = "a" * 300
        is_expected.to eq true
        group.description = "a" * 299
        is_expected.to eq true
      end
      it "number of join_fee is greater than 1000: false" do
        group.join_fee = 1001
        is_expected.to eq false
      end
      it "number of join_fee is equal or less than 1000" do
        group.description = 1000
        is_expected.to eq true
        group.description = 999
        is_expected.to eq true
      end
      it "number of max_group_member is greater than 100: false" do
        group.max_group_member = 101
        is_expected.to eq false
      end
      it "number of max_group_member is less than 2: false" do
        group.max_group_member = 1
        is_expected.eq false
      end
      it "number of max_group_member is less than 100 and greater than 2" do
        group.max_group_member = 2
        is_expected.to eq true
        group.max_group_member = 100
        is_expected.to eq true
        group.max_group_member = 50
        is_expected.to eq true
      end
    end
  end
end
