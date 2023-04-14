class Tag < ApplicationRecord
  has_many :taggings
  has_many :tasks, through: :taggings

  scope :search, -> (query) { where("name LIKE ?", "%#{query}%") }
end
