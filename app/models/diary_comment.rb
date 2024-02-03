class DiaryComment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :user_id, :diary_id, :content, presence: true
  validates :content, length: { maximum: 1000 }

  def is_own_comment?(user)
    self.user_id == user.id
  end
end
