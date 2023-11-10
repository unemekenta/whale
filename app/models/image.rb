class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validate :validate_image_file_size

  has_many :diaries_image_relations
  has_many :diaries, through: :diaries_image_relations

  validates :user_id, :image, :image_content_type, :image_file_size, :image_type, :caption, presence: true

  private

  def validate_image_file_size
    if image.file && image.file.size > 10.megabytes
      errors.add(:image, "ファイルサイズは10MB以下にしてください")
    end
  end
end
