class ToppagesController < ApplicationController
  def index
    # @events = Event.all.order(event_date: "ASC")
    this_month_day = Time.zone.today
    @this_month = Event.where(event_date: this_month_day.in_time_zone.all_month)
    @next_month_day = Time.zone.today>>1
    @next_month = Event.where(event_date: @next_month_day.in_time_zone.all_month)
  end
end
