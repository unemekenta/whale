class DiaryComment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :user_id, :diary_id, :content, presence: true
end
