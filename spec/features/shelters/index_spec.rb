require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    visit "/shelters"
  end

  it "has the name of each shelter on the shelter index page" do

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it "has a link to create a new shelter" do

    expect(page).to have_link("New Shelter")
    click_link "New Shelter"
    expect(current_path).to eq("/shelters/new")
  end

  it "has a link to edit each shelter" do
    within "#shelter-#{@shelter_1.id}" do
      expect(page).to have_link("Edit #{@shelter_1.name}")
      expect(page).to have_link("Delete #{@shelter_1.name}")
    end
  end
end
