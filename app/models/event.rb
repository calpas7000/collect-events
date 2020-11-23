class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, length: { maximum: 255 }
  validates :game_title, presence: true, length: { maximum: 255 }
  validates :event_date, presence: true
  validates :entry, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 4294967296 }
  
  enum other: { other_f: false, other_t: true }
  validates :other, inclusion: {in: ["other_t", "other_f"]}
  enum pc: { pc_f: false, pc_t: true }
  validates :pc, inclusion: {in: ["pc_t", "pc_f"]}
  enum ps4: { ps4_f: false, ps4_t: true }
  validates :ps4, inclusion: {in: ["ps4_t", "ps4_f"]}
  enum ps5: { ps5_f: false, ps5_t: true }
  validates :ps5, inclusion: {in: ["ps5_t", "ps5_f"]}
  enum xbox_one: { xbox_one_f: false, xbox_one_t: true }
  validates :xbox_one, inclusion: {in: ["xbox_one_t", "xbox_one_f"]}
  enum xbox_series_xs: { xbox_series_xs_f: false, xbox_series_xs_t: true }
  validates :xbox_series_xs, inclusion: {in: ["xbox_series_xs_t", "xbox_series_xs_f"]}
  enum switch: { switch_f: false, switch_t: true }
  validates :switch, inclusion: {in: ["switch_t", "switch_f"]}
  enum smartphone: { smartphone_f: false, smartphone_t: true }
  validates :smartphone, inclusion: {in: ["smartphone_t", "smartphone_f"]}
  
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
  end
  
  scope :search_word_like, -> (search_word) { where("title LIKE ? OR content LIKE ?", "%#{search_word}%","%#{search_word}%") if search_word.present? }
  scope :event_date_from, -> (from) { where("? <= event_date", from) if from.present? }
  scope :event_date_to, -> (to) { where("event_date <= ?", to) if to.present? }
end
