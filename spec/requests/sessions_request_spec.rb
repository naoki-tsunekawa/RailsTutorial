require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  let!(:user) { FactoryBot.create(:user) }
  describe 'POST #create' do
    it 'log in and redirect to detail page' do
      post login_path, params: { session: { email: user.email,
                                            password: user.password } }
      expect(response).to redirect_to user_path(user)
      # ログインしているかのテスト(ここでis_logged_in?を使ってます。)
      expect(is_logged_in?).to be_truthy
    end
  end

  # logoutのテスト
  describe 'DELETE #destroy' do
    it 'log out and redirect to root page' do
      delete logout_path
      expect(response).to redirect_to root_path
      # ここでセッションの値をテストしています。
      # sessonの値がfalse
      expect(is_logged_in?).to be_falsey
    end
  end

end
