class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        # # remember meのチェックボックスの値によってcookieに保存するかどうか判別
        # # if params[:session][:remember_me] == '1'
        # #   remember(user)
        # # else
        # #   forget(user)
        # # end
        # # ↑同じ意味
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # フレンドリーフォワーディング
        # ログインする前に記憶したurlもしくはデフォルトのurlへリダイレクトする
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
