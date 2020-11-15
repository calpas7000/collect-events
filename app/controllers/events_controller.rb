class EventsController < ApplicationController
  before_action :correct_event_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:create, :new, :destroy]
  
  def index
    @search_params = event_search_params
    if @search_params.empty?
      @search_params[:event_date_from] = Time.zone.now
    end
    @events = Event.search(@search_params).order(event_date: "ASC").page(params[:page]).per(12)
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
    @comment = @event.comments.build
    @comments = @event.comments.order(id: :desc)
    counts_event(@event)
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :event_date, :content, :other, :pc, :ps4, :ps5, :xbox_one, :xbox_series_xs, :switch, :smartphone)
  end
  
  def correct_event_user
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_back(fallback_location: root_path)
    end
  end
  
  def event_search_params
    params.fetch(:search, {}).permit(:search_word, :event_date_from, :event_date_to )
  end
end
