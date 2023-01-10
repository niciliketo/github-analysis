# frozen_string_literal: true

##
# Base Pundit Policy class for the Application
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    @user = user
    @record = record
  end

  ##
  # We are ok to index, as long as we are logged in
  # The logged in check is done at application policy
  # We will check which records to show in the scope
  def index?
    true
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  ##
  # Scopes are used for the index actions, where we dont have an object to test
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user

      @user = user
      @scope = scope
    end
  end
end
