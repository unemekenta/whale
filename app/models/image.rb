class Image < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, presence: true
  validate :validate_image_file_size

  private

  def validate_image_file_size
    if image.file && image.file.size > 10.megabytes
      errors.add(:image, "ファイルサイズは10MB以下にしてください")
    end
  end
end
