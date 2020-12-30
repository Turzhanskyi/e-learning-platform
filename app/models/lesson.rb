# frozen_string_literal: true

class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true
  validates :title, length: { maximum: 70 }
  validates_uniqueness_of :title, scope: :course_id

  belongs_to :course, counter_cache: true
  # Course.find_each { |course| Course.reset_counters(course.id, :lessons) }
  has_many :user_lessons, dependent: :destroy

  has_rich_text :content
  has_one_attached :video
  has_one_attached :video_thumbnail
  validates :video,
            content_type: %w[video/mp4],
            size: { less_than: 50.megabytes, message: 'size should be under 50 megabytes' }
  validates :video_thumbnail,
            content_type: %w[image/png image/jpg image/jpeg],
            size: { less_than: 500.kilobytes, message: 'size should be under 500 kilobytes' }

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  include RankedModel
  ranks :row_order, with_same: :course_id

  def to_s
    title
  end

  def prev
    course.lessons.where('row_order < ?', row_order).order(:row_order).last
  end

  def next
    course.lessons.where('row_order > ?', row_order).order(:row_order).first
  end

  def viewed(user)
    user_lessons.where(user: user).present?
  end
end
