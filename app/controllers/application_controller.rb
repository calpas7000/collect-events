class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts_user(user)
    @count_favorite_events = user.favorite_events.count
  end
  
  def counts_event(event)
    @count_comments = event.comments.count
    @count_favorites = event.favorites.count
  end
end
