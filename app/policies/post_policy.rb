# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def destroy?
    record.user_id == user&.id
  end

  def edit?
    destroy?
  end

  def update?
    destroy?
  end
end
