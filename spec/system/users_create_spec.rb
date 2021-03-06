require 'rails_helper'

RSpec.describe "Users Create", type: :system do
  # ユーザ新規登録のテスト
  describe 'user create a new account' do
    # 有効な値が入力された時
    context 'enter an valid values' do
      before do
        visit signup_path
        fill_in 'Name', with: 'testuser'
        fill_in 'Email', with: 'testuser@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Create my account'
      end

      # フラッシュメッセージが表示される
      it 'gets an flash message' do
        expect(page).to have_selector('.alert-success', text: 'Welcome to the Sample App!')
      end
    end

    # 無効な値が入力された時
    context 'enter an invalid values' do
      before do
        visit signup_path
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''
        click_button 'Create my account'
      end
      subject { page }
      # エラーの検証
      it 'gets an errors' do
        is_expected.to have_selector('#error_explanation')
        is_expected.to have_selector('.alert-danger', text: 'The form contains 4 errors.')
        is_expected.to have_content("Password can't be blank")
      end
      # 現在いるURLの検証
      it 'render to /signup url' do
        is_expected.to have_current_path '/users'
      end
    end
  end
 end
