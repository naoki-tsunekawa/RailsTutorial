class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      # 遷移しようとしたurlを記憶する
      store_location
      # フラッシュメッセージの設定
      flash[:danger] = "Please log in."
      # ログイン画面へ遷移する
      redirect_to login_url
    end
  end
end
