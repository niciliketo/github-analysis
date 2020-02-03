require "application_system_test_case"

class ReposTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @repo = repos(:one)
    sign_in users(:one)
  end

  test "visiting the index" do
    visit repos_url
    assert_selector "h1", text: "Repos"
  end

  test "destroying a Repo" do
    visit repos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end
    sleep 6
    assert_text "Repo was successfully destroyed"
  end
end
