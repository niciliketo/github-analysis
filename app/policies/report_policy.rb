# frozen_string_literal: true

##
# Punit policies for the PullRequest model
class ReportPolicy < ApplicationPolicy
  attr_reader :user, :repo

  def show?
    permitted_to_report
  end

  def new?
    true
  end

  # TODO: add auth here?
  def create?
    permitted_to_report
  end

  # TODO: add auth here?
  def update?
    permitted_to_report
  end

  def destroy?
    permitted_to_report
  end

  ##
  # Scope for the index action
  # TODO: makes this more restrictive
  class Scope < Scope
    def resolve
      scope.where('1 = 2')
    end
  end

  private
  # TODO: makes this more restrictive / remove model
  def permitted_to_report
    true
  end
end
