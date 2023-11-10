# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  mount_uploader :image, AvatarUploader

  include DeviseTokenAuth::Concerns::User

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy

  validates :provider, :uid, :encrypted_password, presence: true

  def self.check_user_id(user_id, current_user_id)
    unless user_id.to_i == current_user_id.to_i
      raise StandardError.new('Unauthorized: User ID does not match current user')
    end
  end
end
