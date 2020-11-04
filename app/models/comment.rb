class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  
  validates :content, presence: true, length: { maximum: 4294967296 }
end
