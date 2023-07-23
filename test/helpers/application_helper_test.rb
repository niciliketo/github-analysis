# frozen_string_literal: true

require 'test_helper'

# Tests for the application helper methods
class ApplicationHelperTest < ActionView::TestCase
  test 'ldate handles nil date' do
    assert_equal ldate(nil, format: :short), '-'
  end

  test 'ldate handles not nil date' do
    assert_equal ldate(Date.new(2023, 1, 1), format: :short), 'Jan 01'
  end
end
