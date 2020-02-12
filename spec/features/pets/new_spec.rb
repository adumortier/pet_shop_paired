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

    visit "/shelters/#{@shelter.id}/pets"
  end

  it "can add a new pet through the link to Create Pet" do

    click_link "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Peewee"
    fill_in :description, with: "Lively pup"
    fill_in :age, with: 3
    select 'F', :from => :sex

    click_button "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to have_content("Peewee")
    expect(page).to have_content("Lively pup")
    expect(page).to have_content(3)
    expect(page).to have_content("F")
  end

  it "shows flash message if new pet form is filled out incorrectly" do

    click_link "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Peewee"
    fill_in :description, with: ""
    fill_in :age, with: ""
    select 'F', :from => :sex

    click_button "Create Pet"
    expect(page).to have_content("Age can't be blank and Description can't be blank")
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")
    visit "/shelters/#{@shelter.id}/pets"
    expect(page).to_not have_content("Peewee")
  end

  it "shows flash message if pet age is a negative number" do

    click_link "Create Pet"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Cracky"
    fill_in :description, with: "smart"
    fill_in :age, with: "-3"
    select 'F', :from => :sex

    click_button "Create Pet"
    expect(page).to have_content("You must enter a positive value for the age")
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/new")
    visit "/shelters/#{@shelter.id}/pets"
    expect(page).to_not have_content("Cracky")
  end
end
