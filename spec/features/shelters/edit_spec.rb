require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Gworgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    visit "/shelters/#{@shelter_1.id}/edit"
  end

  it "can edit and update a shelter's information" do

    fill_in "Name", with: "Barbara's Palace"
    click_on "Update #{@shelter_1.name}"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Barbara's Palace")
    expect(page).to_not have_content("Abby's Shelter")
  end

  it "has a flash message if a form is edited incompletely" do
    fill_in :name, with: ""
    fill_in :address, with: "456 Dublin St"
    fill_in :city, with: "Phoenix"
    fill_in :state, with: ""
    fill_in :zip, with: "60341"
    click_button "Update #{@shelter_1.name}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    expect(page).to have_content("The following fields are missing : name, state")
  end
end
