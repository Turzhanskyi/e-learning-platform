# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    @record.lesson.course.user_id == @user.id ||
      @record.user_id == @user.id ||
      @user.has_role?(:admin)
  end
end
