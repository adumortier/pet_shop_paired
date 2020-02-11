require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    visit "/shelters/new"
  end

  it "can fill out a new form for a new shelter" do

    fill_in :name, with: "Marlee's Place"
    fill_in :address, with: "456 Dublin St"
    fill_in :city, with: "Phoenix"
    fill_in :state, with: "AZ"
    fill_in :zip, with: "60341"
    click_button "Submit"
    expect(current_path).to eq('/shelters')
    expect(page).to have_content("Marlee's Place")
  end

  it "has a flash message if new form is filled incompletely" do
    fill_in :name, with: ""
    fill_in :address, with: "456 Dublin St"
    fill_in :city, with: "Phoenix"
    fill_in :state, with: "AZ"
    fill_in :zip, with: ""
    click_button "Submit"
    expect(current_path).to eq('/shelters/new')
    expect(page).to have_content("Name can't be blank and Zip can't be blank")
  end
end
