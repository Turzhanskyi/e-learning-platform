# frozen_string_literal: true

class TagPolicy < ApplicationPolicy
  def index?
    @user.has_role?(:admin)
  end

  def destroy?
    @user.has_role?(:admin)
  end
end
