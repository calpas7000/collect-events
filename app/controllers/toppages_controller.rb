class ToppagesController < ApplicationController
  def index
    @events = Event.all.order(event_date: "ASC")
    @this_month = Time.zone.today
    @this_month_day = @this_month.all_month
    @next_month = Time.zone.today>>1
    @next_month_day = @next_month.all_month
  end
end
