class UsersController < ApplicationController
  # ログインしているユーザのみ使えるアクション
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # 別ユーザが編集しないようにする。
  before_action :correct_user,   only: [:edit, :update]
  # 管理者ユーザのみ削除可能にする。
  before_action :admin_user,     only: :destroy

  # ユーザ一覧
  def index
    # DBからユーザを全件取得する
    @users = User.page(params[:page]).per(10)
    # アカウント有効化してあるユーザのみ取得する
    @users = User.where(activated: true).page(params[:page]).per(10)
  end

  # ユーザ新規登録
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # ユーザ作成に成功した場合ユーザのページに遷移する
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  # ユーザ詳細
  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated?
  end

  # ユーザ編集
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    # 削除のリンクが見える管理者ユーザのみ削除可能
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

    # strong parameter
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション
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

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # sessions_helper.rbにcurrent_user?メソッドを追加(リファクタリング)
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
