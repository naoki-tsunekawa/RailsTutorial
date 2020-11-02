require 'rails_helper'

RSpec.describe "UsersIndex", type: :system do
	# テスト用のユーザ作成
	let(:users) { FactoryBot.create_list(:other_user, 30) }
	# 確認用ユーザ作成
	let!(:user) { FactoryBot.create(:user, email: 'index@example.com', password: 'password') }

	# テストユーザ作成されているか確認
	describe "test user creation confirmation" do
		before do
			# テスト用ユーザ作成
			users
		end
		# テストユーザ作成されているか確認
		it { expect(User.count).to eq(31) }
	end

	describe "index" do
		before do
			# テストユーザ作成
			users
			# 任意のユーザでログイン
			valid_login user
			# ユーザ一覧画面に遷移
			users_path
		end

		# ページネーションのテスト
		# describe "pagination" do
		# 	it "list each user" do
    #     User.paginates_per(page: 1).each do |user|
    #       expect(page).to have_css("li", text: user.name)
    #     end
		# 	end
		# end

	end


end
