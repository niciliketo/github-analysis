# frozen_string_literal: true

require 'test_helper'

##
# Test Pundit policies for the Repo Model
class RepoPolicyTest < ActiveSupport::TestCase
  def test_new_allowed_for_user
    user = users(:one)
    repo_policy = RepoPolicy.new(user, Repo.new)
    assert repo_policy.new?
  end

  def test_new_not_allowed_for_no_user
    user = nil
    assert_raises(Pundit::NotAuthorizedError) { RepoPolicy.new(user, Repo.new) }
  end

  def test_create
    user = users(:one)
    repo_policy = RepoPolicy.new(user, Repo.new)
    assert repo_policy.new?
  end

  def test_show_permitted
    user = users(:one)
    repo = repos(:one)
    repo_policy = RepoPolicy.new(user, repo)
    assert repo_policy.show?
  end

  def test_show_not_permitted
    user = users(:two)
    repo = repos(:one)
    repo_policy = RepoPolicy.new(user, repo)
    assert !repo_policy.show?
  end

  def test_index_not_permitted
    skip('To be added')
  end

  def test_index_permitted
    skip('To be added')
  end

  def test_index_scoped_correctly
    skip('To be added')
  end
end