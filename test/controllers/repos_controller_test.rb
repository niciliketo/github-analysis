# frozen_string_literal: true

require 'test_helper'

##
# Tests for the Repos Controller
class ReposControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @repo = repos(:one)
    sign_in users(:one)
  end

  test 'should get index' do
    get repos_url
    assert_response :success
  end

  test 'should get new' do
    # Need to stub repos, so we dont
    # try and retrieve them from github.
    users(:one).stub :repos, [] do
      get new_repo_url
      assert_response :success
    end
  end

  test 'should create repo' do
    assert_difference('Repo.count') do
      post repos_url,
           params: { repo: { full_name: @repo.full_name, data: @repo.data, public: @repo.public,
                             user_id: @repo.user_id } }
    end

    assert_redirected_to repo_url(Repo.last)
  end

  test 'should show repo' do
    get repo_url(@repo)
    assert_response :success
  end

  test 'should get edit' do
    get edit_repo_url(@repo)
    assert_response :success
  end

  test 'should update repo' do
    patch repo_url(@repo),
          params: { repo: { full_name: @repo.full_name, data: @repo.data, public: @repo.public,
                            user_id: @repo.user_id } }
    assert_redirected_to repo_url(@repo)
  end

  test 'should destroy repo' do
    assert_difference('Repo.count', -1) do
      delete repo_url(@repo)
    end

    assert_redirected_to repos_url
  end
end
