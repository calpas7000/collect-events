class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:events]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to "/"
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  def events
    @user = current_user
    @events = @user.events.page(params[:page])
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end