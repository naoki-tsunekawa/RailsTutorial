require 'rails_helper'

RSpec.describe "Users", type: :request do

  # 変数宣言
  let(:test_user) { FactoryBot.create(:user) }
  let(:other_test_user) { FactoryBot.create(:user, email: 'otheruser@example.com') }

  describe "GET /signup" do
    it "responds successfully" do
      get signup_path
      expect(response).to have_http_status 200
    end
  end

  # create action
  describe 'create' do
    context 'valid request' do
      it 'adds a user' do
        expect do
          post signup_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change(User, :count).by(1)
      end

      context 'adds a user' do
        before { post signup_path, params: { user: FactoryBot.attributes_for(:user) } }
        subject { response }

        it { is_expected.to redirect_to user_path(User.last) }
        it { is_expected.to have_http_status 302 }

        it 'log in' do
          expect(is_logged_in?).to be_truthy
        end

      end
    end
  end

  # edit action
  describe 'edit' do
    context 'valid request' do
      # 認可されたユーザーとして
      it "responds successfully" do
        sign_in_as test_user
        get edit_user_path(test_user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      # ログインしていないユーザーの場合
      context "as a guest" do
        # ログイン画面にリダイレクトすることを確認する。
        it "redirects to the login page" do
          # loginせずに編集ページに遷移せずにログインページに遷移することを確認
          sign_out_as test_user
          get edit_user_path(test_user)
          expect(response).to have_http_status 302
          expect(response).to redirect_to login_path
        end
      end

      # アカウントが違うユーザが編集画面に遷移した場合
      context "as other user" do
        # ユーザーを更新できないことを確認する
        it "does not update the user" do
          user_edit_params = FactoryBot.attributes_for(:user, name: "EditName")
          # test_userではないother_test_userでログインする
          sign_in_as other_test_user
          # test_userでupdateする
          patch user_path(test_user), params: { user: user_edit_params}
          # 更新されていないことを確認
          # expect(user.reload.name).to eq other_user.name
          # 更新できずにルートページに遷移する
          expect(response).to redirect_to root_path
        end
      end

    end
  end

end
