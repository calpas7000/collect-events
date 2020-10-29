class EventsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def index
  end
  
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "イベントを作成しました。"
      redirect_to @event
    else
      flash.now[:danger] = "イベントの作成に失敗しました。"
      render :new
    end
  end

  def new
    @event = Event.new
  end

  def destroy
    @event.destroy
    flash[:success] = "イベントを削除しました。"
    redirect_to root_url
  end

  def show
    @event = Event.find(params[:id])
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :event_date, :place, :content)
  end
  
  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_back(fallback_location: root_path)
    end
  end
end
