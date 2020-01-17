require 'test_helper'

require 'test_helper'

class PullRequestsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @repo = repos(:one)
    @pull_request = pull_requests(:one)
    sign_in users(:one)
  end

  test "should get index" do
    get repo_pull_requests_url(@repo)
    assert_response :success
  end

  test "should get new" do
    get new_repo_pull_request_url(@repo)
    assert_response :success
  end

  test "should create pull_request" do
    assert_difference('PullRequest.count') do
      post repo_pull_requests_url(@repo), params: { pull_request: { creator: @pull_request.creator, milestone: @pull_request.milestone, number: @pull_request.number, pr_created_at: @pull_request.pr_created_at, pr_merged_at: @pull_request.pr_merged_at } }
    end

    assert_redirected_to repo_pull_request_url(@repo, PullRequest.last)
  end

  test "should show pull_request" do
    get repo_pull_request_url(@repo, @pull_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_repo_pull_request_url(@repo, @pull_request)
    assert_response :success
  end

  test "should update pull_request" do
    patch repo_pull_request_url(@repo, @pull_request), params: { pull_request: { creator: @pull_request.creator, milestone: @pull_request.milestone, number: @pull_request.number, pr_created_at: @pull_request.pr_created_at, pr_merged_at: @pull_request.pr_merged_at } }
    assert_redirected_to repo_pull_request_url(@repo, @pull_request)
  end

  test "should destroy pull_request" do
    assert_difference('PullRequest.count', -1) do
      delete repo_pull_request_url(@repo, @pull_request)
    end

    assert_redirected_to repo_pull_requests_url(@repo)
  end
end
