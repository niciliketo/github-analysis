# frozen_string_literal: true

##
# Base controller for the application
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index
end
