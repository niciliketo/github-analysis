# frozen_string_literal: true

##
# Punit policies for the PullRequest model
class PullRequestPolicy < ApplicationPolicy
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
  # At the moment we really only verify that the user 
  # has permission on the repo, so not much to do here
  class Scope < Scope
    def resolve
      scope
    end
  end

  private

  def permitted_to_pull_request
    @record.repo.user == @user
  end
end
