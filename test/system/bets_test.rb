require "application_system_test_case"

class BetsTest < ApplicationSystemTestCase
  setup do
    @bet = bets(:one)
  end

  test "visiting the index" do
    visit bets_url
    assert_selector "h1", text: "Bets"
  end

  test "should create bet" do
    visit bets_url
    click_on "New bet"

    fill_in "Created at", with: @bet.created_at
    fill_in "Description", with: @bet.description
    fill_in "Minimum fee", with: @bet.minimum_fee
    check "Outcome" if @bet.outcome
    fill_in "Owner", with: @bet.owner_id
    check "Public" if @bet.public
    fill_in "Title", with: @bet.title
    click_on "Create Bet"

    assert_text "Bet was successfully created"
    click_on "Back"
  end

  test "should update Bet" do
    visit bet_url(@bet)
    click_on "Edit this bet", match: :first

    fill_in "Created at", with: @bet.created_at
    fill_in "Description", with: @bet.description
    fill_in "Minimum fee", with: @bet.minimum_fee
    check "Outcome" if @bet.outcome
    fill_in "Owner", with: @bet.owner_id
    check "Public" if @bet.public
    fill_in "Title", with: @bet.title
    click_on "Update Bet"

    assert_text "Bet was successfully updated"
    click_on "Back"
  end

  test "should destroy Bet" do
    visit bet_url(@bet)
    click_on "Destroy this bet", match: :first

    assert_text "Bet was successfully destroyed"
  end
end
