require 'rails_helper'

RSpec.describe "Users", type: :request do

  # 変数宣言
  let(:user) { FactoryBot.create(:user) }
  let(:admin_user) { FactoryBot.create(:user, admin: true)}
  let(:other_user) { FactoryBot.create(:user, email: 'otheruser@example.com') }
  let(:admin_params) { FactoryBot.attributes_for(:user, admin: true) }

  # サインアップ画面遷移テスト
  describe "GET /signup" do
    it "responds successfully" do
      get signup_path
      expect(response).to have_http_status 200
    end
  end

  # ユーザ新規作成テスト
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

  # ユーザ編集テスト
  describe 'edit' do
    context 'valid request' do
      # 認可されたユーザーとして
      it "responds successfully" do
        sign_in_as user
        get edit_user_path(user)
        expect(response).to be_success
        expect(response).to have_http_status 200
      end

      # ログインしていないユーザーの場合
      context "as a guest" do
        # ログイン画面にリダイレクトすることを確認する。
        it "redirects to the login page" do
          # loginせずに編集ページに遷移せずにログインページに遷移することを確認
          sign_out_as user
          get edit_user_path(user)
          expect(response).to have_http_status 302
          expect(response).to redirect_to login_path
        end
      end

      # アカウントが違うユーザが編集画面に遷移した場合
      context "as other user" do
        # ユーザーを更新できないことを確認する
        it "does not update the user" do
          user_edit_params = FactoryBot.attributes_for(:user, name: "EditName")
          # userではないother_userでログインする
          sign_in_as other_user
          # userでupdateする
          patch user_path(user), params: { user: user_edit_params}
          # 更新されていないことを確認
          # expect(user.reload.name).to eq other_user.name
          # 更新できずにルートページに遷移する
          expect(response).to redirect_to root_path
        end
      end

    end
  end

  # admin属性変更禁止テスト
  describe 'admin' do
    # web経由で変更できないこと
    it 'should not allow the admin attribute to be edited via the web' do
      # sign_in_as user
      patch user_path(user), params: { user: admin_params }
      # DBに保存されたuserのadminの値がtrueではないことを確認
      expect(user.reload).to_not be_admin
    end
  end

  # ユーザ削除テスト
  describe 'delete' do
    before do
      # 削除データの為のユーザを作成
      user
    end
    # 管理者ユーザの場合としてユーザを削除できること
    context "as an authorized user" do
      # ユーザ削除できること
      it "deletes a user" do
        sign_in_as admin_user
        expect {
          delete user_path(user), params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end

    # 管理者ユーザではないユーザの場合
    context "as au unauthorized user" do
      # ユーザ削除できないこと
      it "redirects to the dashboard" do
        sign_in_as other_user
        expect {
          delete user_path(user), params: { id: user.id }
        }.to change(User, :count).by(0)
      end
    end
  end

end
