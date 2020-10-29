require 'rails_helper'

RSpec.describe 'UsersEdits', type: :system do
  # 変数宣言
  let!(:user) { FactoryBot.create(:user, email: 'edituser@example.com', password: 'password') }

  # ユーザの編集に成功する
  describe 'user edit account' do
    context 'successful edit' do

      it 'successful user edit' do
        # フレンドリーフォーワーディングのテスト
        # (ユーザ編集画面に遷移してからログイン処理後に編集画面に遷移するテスト)
        # edit pathに遷移する。
        visit edit_user_path(user)
        # ログイン
        valid_login user
        # 編集画面でユーザ情報を編集
        fill_in "Name", with: "EditTestUser"
        fill_in "Email", with: "editupdate@example.com"
        # パスワードをからの状態でも保存できるようにする
        # fill_in "Password", with: "supervisor"
        # fill_in "Password confirmation", with: "supervisor"
        click_button "Save changes"
        expect(current_path).to eq user_path(user)
        expect(user.reload.email).to eq "editupdate@example.com"
      end
    end
  end

  # ユーザーは編集に失敗する
  describe 'unsuccessful edit' do
    before do
      # userでログイン
      valid_login user
    end
    it 'unsuccessful user edit' do
      # userの編集ページに遷移する
      visit edit_user_path(user)
      # 編集画面でユーザ情報を編集
      fill_in "Name", with: "EditTestUser"
      fill_in "Email", with: "editupdate@example.com"
      # パスワード確認の値を間違える
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "passwordfoo"
      click_button "Save changes"
      expect(user.reload.email).to_not eq "editupdate@example.com"
    end
  end

end
