require 'rails_helper'

RSpec.describe "Microposts", type: :request do
  describe "Microposts#create" do
    let(:micropost) { FactoryBot.attributes_for(:micropost) }
    let(:post_request) { post microposts_path, params: { micropost: micropost } }

    # ログインしていない状態の投稿テスト
    context "when not logged in" do
      it "doesn't change Micropost's count" do
        expect { post_request }.to change(Micropost, :count).by(0)
      end

      it "redirects to login_url" do
        expect(post_request).to redirect_to login_url
      end
    end
	end

  # マイクロポストに対する削除テスト
	describe "Microposts#destroy" do
    let!(:micropost) { FactoryBot.create(:micropost) }
    let(:delete_request) { delete micropost_path(micropost) }

    # ログインしていない状態の削除テスト
    context "when not logged in" do
      it "doesn't change Micropost's count" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "redirects to login_url" do
        expect(delete_request).to redirect_to login_url
      end
    end

    # 間違ったユーザによるマイクロポスト削除に対してテスト
    context "when logged in user tyies to delete another user's micropost" do
      let(:user) { FactoryBot.create(:user) }

      # ログイン処理
      before { sign_in_as user }

      it "doesn't change Micropost's count" do
        expect { delete_request }.to change(Micropost, :count).by(0)
      end

      it "redirects to root_url" do
        expect(delete_request).to redirect_to root_url
      end
    end
  end
end
