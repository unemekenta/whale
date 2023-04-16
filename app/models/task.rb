class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :comments, foreign_key: "task_id", dependent: :destroy
end
