require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    Shelter.destroy_all
    Pet.destroy_all

      shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
      pet_1 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )
      pet_2 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Paulie",
        age: 3,
        sex: "F",
        description: "Good dog"
        )

    visit "/favorites"
  end

    it "has text when there are no favorited pets" do

      within("#nav") do
      expect(page).to have_content("0")
    end

    expect(page).to have_content("You have no favorited pets at this time.")
  end
end

# User Story 14, No Favorites Page

# When I have not added any pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see text saying that I have no favorited pets
