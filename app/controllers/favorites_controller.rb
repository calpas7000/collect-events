class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    event = Event.find(params[:event_id])
    current_user.add_favorite(event)
    flash[:success] = "イベントをお気に入りに追加しました。"
    redirect_to event
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.delete_favorite(event)
    flash[:success] = "イベントをお気に入りから削除しました。"
    redirect_to event
  end
end
