class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  attr_accessor :remember_token
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(rememberdigest).is_password?(remember_token)
  end
  
  #ログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
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
  
  mount_uploader :image, ImageUploader
  
end
