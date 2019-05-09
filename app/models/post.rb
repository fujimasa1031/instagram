# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :photos

  def liked_by(current_user)
    Like.find_by(user_id: current_user.id)
  end
end
