class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    event = Event.find(params[:event_id])
    current_user.add_favorite(event)
    flash[:success] = "イベントをお気に入りに追加しました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.delete_favorite(event)
    flash[:success] = "イベントをお気に入りから削除しました。"
    redirect_back(fallback_location: root_path)
  end
end
