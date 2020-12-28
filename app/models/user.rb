# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  validate :must_have_a_role, on: :update

  rolify

  has_many :courses, dependent: :nullify
  has_many :enrollments, dependent: :nullify
  has_many :user_lessons, dependent: :nullify

  def to_s
    email
  end

  def username
    email.split(/@/).first
  end

  extend FriendlyId
  friendly_id :email_or_id, use: :slugged

  def email_or_id
    if email.present?
      email
    else
      id
    end
  end

  after_create :assign_default_role

  def assign_default_role
    if User.count == 1
      add_role(:admin) if roles.blank?
      add_role(:teacher)
      add_role(:student)
    else
      add_role(:student) if roles.blank?
      add_role(:teacher) # if you want any user to be able to create own courses
    end
  end

  def online?
    updated_at > 2.minutes.ago
  end

  def buy_course(course)
    enrollments.create(course: course, price: course.price)
  end

  def view_lesson(lesson)
    user_lesson = user_lessons.where(lesson: lesson)
    if user_lesson.any?
      user_lesson.first.increment!(:impressions)
    else
      user_lessons.create(lesson: lesson)
    end
  end

  private

  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end
end
