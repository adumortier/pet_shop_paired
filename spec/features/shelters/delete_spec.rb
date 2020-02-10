require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    Shelter.destroy_all
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Gworgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "has a link to delete the shelter" do
    click_link "Delete #{@shelter_1.name}"
    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("Abby's Shelter")
  end
end
