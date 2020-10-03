class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)  # 実装は終わっていないことに注意!
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    # strong parameter
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
