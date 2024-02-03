class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, :task_id, :content, presence: true
  validates :content, length: { maximum: 1000 }

  def is_own_comment?(user)
    self.user_id == user.id
  end
end
