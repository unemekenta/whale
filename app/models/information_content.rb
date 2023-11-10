class InformationContent < ApplicationRecord
  validates :content, :display_link, :start_at, :end_at, presence: true
end