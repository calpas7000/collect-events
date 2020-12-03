class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  before_action :correct_event_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:create, :new, :destroy]
  
  def index
    @search_params = event_search_params
    @search_params[:event_date_from] = Time.zone.now if @search_params[:event_date_from].blank?
    
    search_events = Event.search(@search_params)
    
    if @search_params[:search_words].present?
      keywords = []
      @events = []
      split_search_words = @search_params[:search_words].split(/[[:blank:]]+/)
      split_search_words.each do |search_word|
        next if search_word == ""
        keywords += Event.where("title LIKE(?) OR content LIKE(?) OR game_title LIKE(?)", "%#{search_word}%", "%#{search_word}%", "%#{search_word}%")
      end
      keywords.uniq!
    
      keywords.each do |keyword|
        @events.push(keyword) if search_events.include?(keyword)
      end
      
    else
      @events = search_events
    end
    
    @events = @events.sort_by{|ms|ms.event_date}
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(12)
  end

  def show
    @comment = @event.comments.build
    @comments = @event.comments.order(id: :desc)
    counts_event(@event)
  end

  def new
    @event = Event.new
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
  
  def edit
    @comments = @event.comments.order(id: :desc)
    counts_event(@event)
  end
  
  def update
    if @event.update(event_params)
      flash[:success] = "イベントが編集されました。"
      redirect_to @event
    else
      flash.now[:danger] = "イベントの編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "イベントを削除しました。"
    redirect_to root_url
  end
  
  private
  
  def set_event
    @event = Event.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:title, :event_date, :game_title, :entry, :content, :other, :pc, :ps4, :ps5, :xbox_one, :xbox_series_xs, :switch, :smartphone)
  end
  
  def correct_event_user
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_back(fallback_location: root_path)
    end
  end
  
  def event_search_params
    params.fetch(:search, {}).permit(:search_words, :event_date_from, :event_date_to, :pc, :ps4, :ps5, :xbox_one, :xbox_series_xs, :switch, :smartphone, :other)
  end
end
