require 'rails_helper'

RSpec.describe 'UsersEdits', type: :system do
  # 変数宣言
  let!(:user) { FactoryBot.create(:user, email: 'edituser@example.com', password: 'password') }

  # ユーザの編集に成功する
  describe 'user edit account' do
    context 'successful edit' do
      before do
        valid_login user
      end

      it 'successful user edit' do
        # edit pathに遷移する。
        visit edit_user_path(user)
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
end
