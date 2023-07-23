# frozen_string_literal: true

module ApplicationHelper
  def ldate(object, **options)
    object ? l(object, **options) : '-'
  end
end
