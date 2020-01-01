require "application_system_test_case"

class PullRequestsTest < ApplicationSystemTestCase
  setup do
    @pull_reqest = pull_reqests(:one)
  end

  test "visiting the index" do
    visit pull_reqests_url
    assert_selector "h1", text: "Pull Reqests"
  end

  test "creating a Pull reqest" do
    visit pull_reqests_url
    click_on "New Pull Reqest"

    fill_in "Creator", with: @pull_reqest.creator
    fill_in "Milestone", with: @pull_reqest.milestone
    fill_in "Number", with: @pull_reqest.number
    fill_in "Pr created at", with: @pull_reqest.pr_created_at
    fill_in "Pr merged at", with: @pull_reqest.pr_merged_at
    click_on "Create Pull reqest"

    assert_text "Pull reqest was successfully created"
    click_on "Back"
  end

  test "updating a Pull reqest" do
    visit pull_reqests_url
    click_on "Edit", match: :first

    fill_in "Creator", with: @pull_reqest.creator
    fill_in "Milestone", with: @pull_reqest.milestone
    fill_in "Number", with: @pull_reqest.number
    fill_in "Pr created at", with: @pull_reqest.pr_created_at
    fill_in "Pr merged at", with: @pull_reqest.pr_merged_at
    click_on "Update Pull reqest"

    assert_text "Pull reqest was successfully updated"
    click_on "Back"
  end

  test "destroying a Pull reqest" do
    visit pull_reqests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pull reqest was successfully destroyed"
  end
end
