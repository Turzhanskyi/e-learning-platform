# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :name, length: { minimum: 1, maximum: 25 }, uniqueness: true

  has_many :course_tags
  has_many :courses, through: :course_tags

  def to_s
    name
  end

  def popular_name
    "#{name}: #{course_tags_count}"
  end
end
