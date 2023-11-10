class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings

  validates :name, presence: true

  scope :search, -> (query) { where("name LIKE ?", "%#{query}%") }
end
