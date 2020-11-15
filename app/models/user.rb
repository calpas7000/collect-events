class User < ApplicationRecord
  before_save { self.email.downcase!}
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :events
  
  has_many :favorites
  has_many :favorite_events, through: :favorites, source: :event
  has_many :reverses_of_favorite, class_name: "Favorite", foreign_key: "event_id"
  
  has_many :favorite, dependent: :destroy
  
  def add_favorite(event)
    self.favorites.find_or_create_by(event_id: event.id)
  end
  
  def delete_favorite(event)
    favorite = self.favorites.find_by(event_id: event.id)
    favorite.destroy if favorite
  end
  
  def favorite?(event)
    self.favorite_events.include?(event)
  end
  
  has_many :comments
  has_many :comment_events, through: :comments, source: :event
  has_many :reverses_of_comment, class_name: "Comment", foreign_key: "event_id"
  
end
