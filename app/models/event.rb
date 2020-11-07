class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, length: { maximum: 100 }
  validates :place, length: { maximum: 255 }
  validates :event_date, presence: true
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
    
    search_word_like(search_params[:search_word])
      .event_date_from(search_params[:event_date_from])
      .event_date_to(search_params[:event_date_to])
      .place_like(search_params[:place])
      # .content_like(search_params[:search_word])
  end
  
  scope :search_word_like, -> (search_word) { where("title LIKE ? OR content LIKE ?", "%#{search_word}%","%#{search_word}%") if search_word.present? }
  scope :event_date_from, -> (from) { where("? <= event_date", from) if from.present? }
  scope :event_date_to, -> (to) { where("event_date <= ?", to) if to.present? }
  scope :place_like, -> (place) { where("place LIKE ?", "%#{place}%") if place.present? }
  # scope :content_like, -> (search_word) { where("content LIKE ?", "%#{search_word}%") if search_word.present? }
end
