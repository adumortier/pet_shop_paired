require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
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
      )

    @shelter.pets << @penny

    visit "/shelters/#{@shelter.id}/pets"
  end

  it "can add a new pet through the link to Create Pet" do

    click_link "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Peewee"
    fill_in :description, with: "Lively pup"
    fill_in :age, with: 3
    fill_in :sex, with: "Female"

    click_button "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to have_content("Peewee")
    expect(page).to have_content("Lively pup")
    expect(page).to have_content(3)
    expect(page).to have_content("Female")
  end
end
