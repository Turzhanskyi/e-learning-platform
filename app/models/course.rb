# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 5 }

  belongs_to :user

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  def to_s
    title
  end
end
