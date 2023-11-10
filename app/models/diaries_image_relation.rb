class DiariesImageRelation < ApplicationRecord
  belongs_to :diary
  belongs_to :image

  validates_uniqueness_of :diary_id, scope: :image_id
  validates :diary_id, :image_id, presence: true
end
