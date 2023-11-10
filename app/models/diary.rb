class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaries_image_relations
  has_many :images, through: :diaries_image_relations
  has_many :diary_comments, foreign_key: "diary_id", dependent: :destroy

  validates :user_id, :title, :is_public, :date, presence: true
  validates :title, length: { maximum: 50 }
  validates :content, length: { maximum: 10000 }
end