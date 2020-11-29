class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, length: { maximum: 255 }
  validates :game_title, presence: true, length: { maximum: 255 }
  validates :event_date, presence: true
  validates :entry, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4294967296 }
  
  has_many :favorites
  has_many :reverses_of_favorite, class_name: "Favorite", foreign_key: "user_id"
  has_many :favorite_users, through: :reverses_of_favorite, source: :user
  
  has_many :favorites, dependent: :destroy
  
  has_many :comments
  has_many :reverses_of_comment, class_name: "Comment", foreign_key: "user_id"
  has_many :comment_users, through: :reverses_of_comment, source: :user
  
  has_many :comments, dependent: :destroy
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    
    event_date_from(search_params[:event_date_from])
      .event_date_to(search_params[:event_date_to])
      .pc_is(search_params[:pc])
      .ps4_is(search_params[:ps4])
      .ps5_is(search_params[:ps5])
      .xbox_one_is(search_params[:xbox_one])
      .xbox_series_xs_is(search_params[:xbox_series_xs])
      .switch_is(search_params[:switch])
      .smartphone_is(search_params[:smartphone])
      .other_is(search_params[:other])
  end

  scope :event_date_from, -> (from) { where("? <= event_date", from) if from.present? }
  scope :event_date_to, -> (to) { where("event_date <= ?", to) if to.present? }
  scope :pc_is, -> (pc) { where(pc: pc) unless pc.to_i.zero? }
  scope :ps4_is, -> (ps4) { where(ps4: ps4) unless ps4.to_i.zero? }
  scope :ps5_is, -> (ps5) { where(ps5: ps5) unless ps5.to_i.zero? }
  scope :xbox_one_is, -> (xbox_one) { where(xbox_one: xbox_one) unless xbox_one.to_i.zero? }
  scope :xbox_series_xs_is, -> (xbox_series_xs) { where(xbox_series_xs: xbox_series_xs) unless xbox_series_xs.to_i.zero? }
  scope :switch_is, -> (switch) { where(switch: switch) unless switch.to_i.zero? }
  scope :smartphone_is, -> (smartphone) { where(smartphone: smartphone) unless smartphone.to_i.zero? }
  scope :other_is, -> (other) { where(other: other) unless other.to_i.zero? }

end
