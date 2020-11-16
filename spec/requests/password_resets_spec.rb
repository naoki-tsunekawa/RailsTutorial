# require 'rails_helper'

# RSpec.describe "PasswordResets", type: :request do
#   let(:user) { FactoryBot.create(:user) }

#   include ActiveJob::TestHelper

#   it 'invalid email address' do
#     # メールアドレスが無効
#     post password_resets_path, params: { password_reset: { email: "" } }
#     expect(response).to render_template(:new)
#   end

#   it 'valid email address' do
#     # メールアドレスが有効
#     post password_resets_path, params: { password_reset: { email: user.email }}
#     expect(response).to redirect_to root_path
#   end

#   it 'Password reset form' do
#     # パスワード再設定フォームのテスト
#     # メールアドレスが無効
#     get edit_password_reset_path(user.reset_token, email: "wrong_emails@example.com" )
#     # フォームのデータが正しいかチェック
#     user = assigns(:user)
#     expect(response).to redirect_to root_path
#   end

#   it 'token invalid' do
#     # メールアドレスが有効で、トークンが無効
#     get edit_password_reset_path('wrong token', email: user.email )
#     expect(response).to redirect_to root_path
#   end

#   it 'both email address and token are valid' do
#     perform_enqueued_jobs do
#       # メールアドレスもトークンも有効
#       get edit_password_reset_path(user.reset_token, email: user.email )
#       user = assigns(:user)
#       expect(response).to render_template(:edit)
#     end

#   end

#   # it "resets password" do
#   #   perform_enqueued_jobs do
#   #     # メールアドレスもトークンも有効
#   #     get edit_password_reset_path(user.reset_token, email: user.email )
#   #     expect(response).to render_template(:edit)
#   #     # 無効なパスワードとパスワード確認
#   #     patch password_reset_path(user.reset_token),
#   #         params: { email: user.email,
#   #                   user: { password: "foobaz",
#   #                           password_confirmation: "barquux" } }
#   #     expect(response).to render_template(:edit)
#   #     # パスワードが空
#   #     patch password_reset_path(user.reset_token),
#   #         params: { email: user.email,
#   #                   user: { password: "",
#   #                           password_confirmation: "" } }
#   #     expect(response).to render_template(:edit)
#   #     # 有効なパスワードとパスワード確認
#   #     patch password_reset_path(user.reset_token),
#   #         params: { email: user.email,
#   #                   user: { password: "foobaz",
#   #                           password_confirmation: "foobaz" } }
#   #     expect(session[:user_id]).to eq user.id
#   #     expect(response).to redirect_to user_path(user)
#   #   end
#   # end
# end
