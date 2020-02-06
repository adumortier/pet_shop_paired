require 'rails_helper'

RSpec.describe 'As a visitor' do
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
  end

    xit "displays a flash message when adding favorite" do

    within("#pets-#{@pet_1.id}") do
      click_link "Add to Favorites"
    end

    expect(page).to have_content("You added #{@pet_1.name} to your favorites.")
  end

    it "can add multiple favorites" do

      within("#pets-#{@pet_1.id}") do
      click_link "Add to Favorites"
    end

      within("#pets-#{@pet_2.id}") do
      click_link "Add to Favorites"
    end

      within("#nav") do
      expect(page).to have_content("2") #making integer in case we replace the Favorites with icon in the future
    end
  end
end
