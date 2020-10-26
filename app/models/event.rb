class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, length: { maximum: 100 }
  validates :place, length: { maximum: 255 }
  validates :event_date, presence: true
  validates :content, presence: true, length: { maximum: 4294967296 }
end
