require 'test_helper'

class PullRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pull_reqest = pull_reqests(:one)
  end

  test "should get index" do
    get pull_reqests_url
    assert_response :success
  end

  test "should get new" do
    get new_pull_reqest_url
    assert_response :success
  end

  test "should create pull_reqest" do
    assert_difference('PullReqest.count') do
      post pull_reqests_url, params: { pull_reqest: { creator: @pull_reqest.creator, milestone: @pull_reqest.milestone, number: @pull_reqest.number, pr_created_at: @pull_reqest.pr_created_at, pr_merged_at: @pull_reqest.pr_merged_at } }
    end

    assert_redirected_to pull_reqest_url(PullReqest.last)
  end

  test "should show pull_reqest" do
    get pull_reqest_url(@pull_reqest)
    assert_response :success
  end

  test "should get edit" do
    get edit_pull_reqest_url(@pull_reqest)
    assert_response :success
  end

  test "should update pull_reqest" do
    patch pull_reqest_url(@pull_reqest), params: { pull_reqest: { creator: @pull_reqest.creator, milestone: @pull_reqest.milestone, number: @pull_reqest.number, pr_created_at: @pull_reqest.pr_created_at, pr_merged_at: @pull_reqest.pr_merged_at } }
    assert_redirected_to pull_reqest_url(@pull_reqest)
  end

  test "should destroy pull_reqest" do
    assert_difference('PullReqest.count', -1) do
      delete pull_reqest_url(@pull_reqest)
    end

    assert_redirected_to pull_reqests_url
  end
end
