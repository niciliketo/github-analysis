require "application_system_test_case"

class ReposTest < ApplicationSystemTestCase
  setup do
    @repo = repos(:one)
  end

  test "visiting the index" do
    visit repos_url
    assert_selector "h1", text: "Repos"
  end

  test "creating a Repo" do
    visit repos_url
    click_on "New Repo"

    fill_in "Data", with: @repo.data
    fill_in "Pull request", with: @repo.pull_request_id
    fill_in "Url", with: @repo.url
    fill_in "User", with: @repo.user_id
    click_on "Create Repo"

    assert_text "Repo was successfully created"
    click_on "Back"
  end

  test "updating a Repo" do
    visit repos_url
    click_on "Edit", match: :first

    fill_in "Data", with: @repo.data
    fill_in "Pull request", with: @repo.pull_request_id
    fill_in "Url", with: @repo.url
    fill_in "User", with: @repo.user_id
    click_on "Update Repo"

    assert_text "Repo was successfully updated"
    click_on "Back"
  end

  test "destroying a Repo" do
    visit repos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Repo was successfully destroyed"
  end
end
