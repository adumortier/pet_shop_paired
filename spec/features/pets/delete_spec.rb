require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    Pet.destroy_all
    @shelter = Shelter.create(
      name: "The Pound",
      address: "123 Main Street",
      city: "Denver",
      state: "CO",
      zip: "80210"
      )

    @penny = Pet.create(
      image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
      name: "Penny",
      age: 2,
      sex: "F",
      description: "cute"
      )

    @shelter.pets << @penny

    visit "/shelters/#{@shelter.id}/pets/#{@penny.id}"
  end

  it "can click delete to delete the pet and remove it from the pets index" do

    click_link "Delete #{@penny.name}"

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to_not have_content("Penny")
  end

  it "delete the pet and remove it from favorites" do

    within("#nav") do
      expect(page).to have_content("0")
    end

    visit "/pets/#{@penny.id}"
    click_link "Add to Favorites"

    within("#nav") do
      expect(page).to have_content("1")
    end

    expect(current_path).to eq("/pets/#{@penny.id}")
    click_link "Delete #{@penny.name}"
    
    within("#nav") do
      expect(page).to have_content("0")
    end

    visit "/favorites"
    expect(page).to_not have_content(@penny.name)
  end
end
