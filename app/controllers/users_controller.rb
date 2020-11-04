class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:events]
  

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
    @events = @user.events.order(event_date: "DESC").page(params[:page])
  end
  
  def favorite_events
    @user = current_user
    @favorite_events = @user.favorite_events.page(params[:page]).per(12)
    counts_user(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
