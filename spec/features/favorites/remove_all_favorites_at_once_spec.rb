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

    visit "/pets"

    within("#pets-#{@pet_1.id}") do
      click_link "Add to Favorites"
    end

    within("#pets-#{@pet_2.id}") do
      click_link "Add to Favorites"
    end

    visit "/favorites"
  end

  xit "has a link to remove all the favorited pets at once" do

    within("#nav") do
      expect(page).to have_content("2")
    end

    click_link "Remove all Favorited Pets"

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("You have no favorited pets at this time.")

    within("#nav") do
      expect(page).to have_content("0")
    end
  end
end

# User Story 15, Remove all Favorite from Favorites Page

# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link to remove all favorited pets
# When I click that link
# I'm redirected back to the favorites page
# I see the text saying that I have no favorited pets
# And the favorites indicator returns to 0
