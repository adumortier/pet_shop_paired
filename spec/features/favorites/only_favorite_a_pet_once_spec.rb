require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all

      @shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
      @pet_1 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )
      @pet_2 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Paulie",
        age: 3,
        sex: "F",
        description: "Good dog"
        )

  end

  it "favorites a pet" do

    visit "/pets/#{@pet_1.id}"

    click_link "Add to Favorites"

      within("#nav") do
      expect(page).to have_content("1")
    end

      visit "/pets/#{@pet_2.id}"

      click_link "Add to Favorites"

      within("#nav") do
      expect(page).to have_content("2")
    end

    visit "/pets/#{@pet_1.id}"

    expect(page).to_not have_link("Add to Favorites")
    expect(page).to have_link("Remove from Favorites")

    click_link "Remove from Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} Removed from Favorites")
    expect(page).to have_content("Add to Favorites")

      within("#nav") do
      expect(page).to have_content("1")
    end
  end
end
