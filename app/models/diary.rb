class Diary < ApplicationRecord
  belongs_to :user
  has_many :diaries_image_relations
  has_many :images, through: :diaries_image_relations
  has_many :diary_comments, foreign_key: "diary_id", dependent: :destroy
end