class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  # ログイン済みユーザーか確認
  def require_user_logged_in
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  # 管理者か確認
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
  
  def counts_user(user)
    @count_favorite_events = user.favorite_events.count
  end
  
  def counts_event(event)
    @count_comments = event.comments.count
    @count_favorites = event.favorites.count
  end
end
