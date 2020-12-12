class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :events, :favorite_events]
  before_action :set_user, only: [:events, :favorite_events]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :correct_or_admin_user, only: :show
  
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_path
    else
      flash.now[:danger] = "ユーザの登録に失敗しました。"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "アカウントを更新しました。"
      redirect_to @user
    else
      flash.now[:danger] = "アカウントの編集に失敗しました。"
      render :edit
    end
    
      # respond_to do |format|
      #   if @user.update(user_params)
      #     format.html { redirect_to @user }
      #     format.js
      #   else
      #     format.html { render :edit }
      #     format.js { render :errors }
      #   end
      # end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to root_url
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def set_user
    @user = current_user
  end
  
  # 正しいユーザーか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end
  
  # ログイン済みのユーザーもしくは管理者か確認
  def correct_or_admin_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) || current_user.admin?
  end
end
