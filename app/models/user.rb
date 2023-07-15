# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :diaries, dependent: :destroy
  has_many :diary_comments, dependent: :destroy
end
