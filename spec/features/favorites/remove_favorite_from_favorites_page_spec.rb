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

    visit "/pets/#{@pet_1.id}"

        click_link "Add to Favorites"

    visit "/pets/#{@pet_2.id}"

        click_link "Add to Favorites"

    visit "/favorites"
  end

  it "can remove each favorited pet with link" do

      within("#pets-#{@pet_1.id}") do
        expect(page).to have_link("Remove from Favorites")
      end

      within("#pets-#{@pet_2.id}") do
        expect(page).to have_link("Remove from Favorites")
      end

      within("#pets-#{@pet_1.id}") do
        click_link("Remove from Favorites")
      end

      expect(current_path).to eq("/favorites")
      # expect(page).to_not have_content("#{@pet_1.name}")

      within("#nav") do
      expect(page).to_not have_content("2")
      expect(page).to have_content("1")
    end
  end
end
