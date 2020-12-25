# frozen_string_literal: true

class Lesson < ApplicationRecord
  validates :title, :content, :course, presence: true

  belongs_to :course, counter_cache: true

  has_rich_text :content

  extend FriendlyId
  friendly_id :title, use: :slugged

  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  def to_s
    title
  end
end
