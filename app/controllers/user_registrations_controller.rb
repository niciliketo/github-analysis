# frozen_string_literal: true

# This controller provides a replacement for the devise login route
# Because we don't permit login with username/password
class UserRegistrationsController < ApplicationController
  def new; end
end
