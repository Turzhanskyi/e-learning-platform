# frozen_string_literal: true

class Course < ApplicationRecord
  validates :title, :short_description, :language, :price, :level, presence: true
  validates :description, presence: true, length: { minimum: 5 }

  belongs_to :user
  has_many :lessons, dependent: :destroy
  has_many :enrollments

  has_rich_text :description

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  def to_s
    title
  end

  def bought(user)
    enrollments.where(user_id: [user.id], course_id: [id]).empty?
  end

  def update_rating
    if enrollments.any? && enrollments.where.not(rating: nil).any?
      update_column :average_rating, enrollments.average(:rating).round(2).to_f
    else
      update_column :average_rating, 0
    end
  end

  LANGUAGES = %i[English Ukrainian Russian Polish].freeze
  def self.languages
    LANGUAGES.map { |language| [language, language] }
  end

  LEVELS = %i[Beginner Intermediate Advanced].freeze
  def self.levels
    LEVELS.map { |level| [level, level] }
  end
end
