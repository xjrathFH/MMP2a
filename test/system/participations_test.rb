require "application_system_test_case"

class ParticipationsTest < ApplicationSystemTestCase
  setup do
    @participation = participations(:one)
  end

  test "visiting the index" do
    visit participations_url
    assert_selector "h1", text: "Participations"
  end

  test "should create participation" do
    visit participations_url
    click_on "New participation"

    check "Anonymous" if @participation.anonymous
    fill_in "Bet", with: @participation.bet_id
    fill_in "Fee", with: @participation.fee
    fill_in "Message", with: @participation.message
    fill_in "Owner", with: @participation.owner_id
    click_on "Create Participation"

    assert_text "Participation was successfully created"
    click_on "Back"
  end

  test "should update Participation" do
    visit participation_url(@participation)
    click_on "Edit this participation", match: :first

    check "Anonymous" if @participation.anonymous
    fill_in "Bet", with: @participation.bet_id
    fill_in "Fee", with: @participation.fee
    fill_in "Message", with: @participation.message
    fill_in "Owner", with: @participation.owner_id
    click_on "Update Participation"

    assert_text "Participation was successfully updated"
    click_on "Back"
  end

  test "should destroy Participation" do
    visit participation_url(@participation)
    click_on "Destroy this participation", match: :first

    assert_text "Participation was successfully destroyed"
  end
end
