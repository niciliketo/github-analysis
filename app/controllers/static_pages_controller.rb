# frozen_string_literal: true

# Serve some static pages
class StaticPagesController < ApplicationController
  skip_after_action :verify_authorized
  def home; end

  def help; end
end
