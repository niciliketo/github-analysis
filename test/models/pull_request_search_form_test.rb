# frozen_string_literal: true

require 'test_helper'

# Class to test the Pull Request Search Form
class PullRequestSearchFormTest < ActiveSupport::TestCase
  describe 'PullRequestSearchForm' do
    it 'serializes params correctly when they are provided' do
      params = { pr_merged_at_start: '2023-01-02', pr_merged_at_end: '2023-01-03',
                 milestone: ['', '14.0.43'], creator: ['', 'John Smith'], merged_by: ['', 'John Smith'] }
      assert_equal PullRequestSearchForm.new(params).serialize,
                   { pr_merged_at: Date.new(2023, 1, 2)..Date.new(2023, 1, 3), merged_by: ['John Smith'],
                     milestone: ['14.0.43'], creator: ['John Smith'] }
    end
    it 'serializes params correctly when they are not provided' do
      params = { }
      assert_equal PullRequestSearchForm.new(params).serialize,
                   { pr_merged_at: ..Date::Infinity.new }
    end

    it 'serializes params correctly when they are blanks' do
      params = { creator: [''] }
      assert_equal PullRequestSearchForm.new(params).serialize,
                   { pr_merged_at: ..Date::Infinity.new }
    end
  end
end
