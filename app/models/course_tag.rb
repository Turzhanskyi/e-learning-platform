# frozen_string_literal: true

class CourseTag < ApplicationRecord
  belongs_to :course
  belongs_to :tag, counter_cache: true
end
