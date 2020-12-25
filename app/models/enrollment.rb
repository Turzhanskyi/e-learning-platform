# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :course, counter_cache: true
  belongs_to :user, counter_cache: true

  validates :user, :course, presence: true

  validates_presence_of :rating, if: :review?
  validates_presence_of :review, if: :rating?

  validates_uniqueness_of :user_id, scope: :course_id  # user cant be subscribed to the same course twice
  validates_uniqueness_of :course_id, scope: :user_id  # user cant be subscribed to the same course twice

  validate :cant_subscribe_to_own_course  # user can't create a subscription if course.user == current_user.id

  scope :pending_review, -> { where(rating: [0, nil, ''], review: [0, nil, '']) }

  extend FriendlyId
  friendly_id :to_s, use: :slugged

  def to_s
    "#{user} #{course}"
  end

  after_save do
    course.update_rating unless rating.nil? || rating.zero?
  end

  after_destroy do
    course.update_rating
  end

  protected

  def cant_subscribe_to_own_course
    if new_record? && user_id.present? && (user_id == course.user_id)
      errors.add(:base, 'You can not subscribe to your own course')
    end
  end
end