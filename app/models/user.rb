# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  has_many :courses
  has_many :enrollments

  validate :must_have_a_role, on: :update

  after_create :assign_default_role

  rolify

  extend FriendlyId
  friendly_id :email_or_id, use: :slugged

  def email_or_id
    if email.present?
      email
    else
      id
    end
  end

  def username
    email.split(/@/).first
  end

  def to_s
    email
  end

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

  private

  def must_have_a_role
    errors.add(:roles, 'must have at least one role') unless roles.any?
  end
end
