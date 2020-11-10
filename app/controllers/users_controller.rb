class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:events, :favorite_events]
  before_action :login_user, only: [:show, :edit, :events, :favorite_events]
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ユーザを登録しました。"
      redirect_to login_path
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  def edit
  end
  
  def events
    @events = @user.events.order(event_date: "DESC").page(params[:page])
  end
  
  def favorite_events
    @events = @user.favorite_events.page(params[:page]).per(12)
    counts_user(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def login_user
    @user = current_user
  end
end
