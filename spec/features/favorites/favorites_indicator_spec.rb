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

      end

  it "displays a flash message when adding favorite" do

    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"
    expect(page).to have_content("You added #{@pet_1.name} to your favorites.")
  end

  it "can add multiple favorites" do

    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{@pet_2.id}"
    click_link "Add to Favorites"
    within("#nav") do
      expect(page).to have_content("2") #making integer in case we replace the Favorites with icon in the future
    end

  end

  it 'redirects to the favorite page' do
    visit "/pets"
    within('#nav') do
      click_link 'Favorites'
    end

    expect(current_path).to eq '/favorites'
  end

  it 'the favorite index shows the pets added as Favorites' do

    visit "/pets/#{@pet_1.id}"
    click_link 'Add to Favorites'

    visit "/pets/#{@pet_2.id}"
    click_link 'Add to Favorites'

    within('#nav') do
      click_link 'Favorites'
    end

    expect(current_path).to eq('/favorites')
    expect(page).to have_content('Penny')
    expect(page).to have_content('Paulie')
  end
end
