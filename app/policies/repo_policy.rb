# frozen_string_literal: true

##
# Punit policies for the Repo model
class RepoPolicy < ApplicationPolicy
  attr_reader :user, :repo

  def show?
    permitted_to_repo
  end

  def new?
    true
  end

  # TODO: add auth here?
  def create?
    permitted_to_repo
  end

  # TODO: add auth here?
  def update?
    permitted_to_repo
  end

  def destroy?
    permitted_to_repo
  end

  ##
  # Scope for the index action
  # Only show this users repos
  class Scope < Scope
    def resolve
      scope.where(user_id: @user)
    end
  end

  private

  def permitted_to_repo
    @record.user == @user
  end
end
