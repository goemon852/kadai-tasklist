class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "ユーザー登録に成功しました"
      redirect_to root_path
    else
      flash[:notice] = "ユーザー登録に失敗しました"
      render :new
    end
  end
end


private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
