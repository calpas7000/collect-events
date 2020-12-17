class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :events, :favorite_events]
  before_action :set_user, only: [:events, :favorite_events, :activation]
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
    @edit = "edit_#{params[:edit]}"
  end
  
  def update
    if params[:remove] == "true"
      @user.remove_image!
      @user.save
      flash[:success] = "アバターを削除しました。"
      redirect_to @user
    elsif @user.authenticate(user_params[:password]) || user_params[:image].present?
      user_params[:password] = nil
      if @user.update(user_params)
        flash[:success] = "アカウントを更新しました。"
        if user_params[:email].present? || @user.email != user_params[:email]
          @user.inactive
          @user.send_activation_email
          flash[:info] = "please check your email to activate your account."
        end
        redirect_to @user
      else
        flash.now[:danger] = "アカウントの編集に失敗しました。"
        redirect_to @user
      end
    else
      flash.now[:danger] = "パスワードが一致しません"
      redirect_to @user
    end
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
  
  def activation
    unless @user.activated?
      @user.create_activation_digest
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to @user
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :remove)
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
