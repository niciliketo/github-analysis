# frozen_string_literal: true

require 'application_system_test_case'

class PullRequestsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @repo = repos(:one)
    @pull_request = pull_requests(:one)
    sign_in(users(:one))
  end

  test 'visiting the index' do
    visit repo_pull_requests_url(@repo)
    assert_text 'Number of PRs: 1'
  end

  test 'destroying a Pull request' do
    visit repo_pull_requests_url(@repo)
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Pull request was successfully destroyed'
  end
end
