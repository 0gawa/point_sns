require 'rails_helper'

RSpec.describe "PostLikeモデルについて", type: :model do
  describe 'アソシエーションの確認' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
