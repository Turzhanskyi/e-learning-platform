# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :user, counter_cache: true
  # User.find_each { |user| User.reset_counters(user.id, :comments) }
  belongs_to :lesson, counter_cache: true
  # Lesson.find_each { |lesson| Lesson.reset_counters(lesson.id, :comments) }

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  def to_s
    content
  end
end
