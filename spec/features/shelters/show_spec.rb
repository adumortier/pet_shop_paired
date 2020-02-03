require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "shows a shelter's information from their show page" do

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "has a link to update the a shelter" do

    expect(page).to have_link "Update #{@shelter_1.name}"
    click_link "Update #{@shelter_1.name}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "shows link to shelter's pets" do

    expect(page).to have_link("Current Pets")
  end
end
