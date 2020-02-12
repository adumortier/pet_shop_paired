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
      description: "cute"
      )

    @shelter.pets << @penny

    visit "/shelters/#{@shelter.id}/pets/#{@penny.id}"
  end

  it "has a link to edit a pet and then can save updates" do

    click_link "Update #{@penny.name}"

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}/edit")

    fill_in "Name", with: "Burnadette"

    click_on "Update #{@penny.name}"
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}")
    expect(page).to have_content("Burnadette")
    expect(page).to_not have_content("Penny")
  end

  it "shows a flash message for specific fields missing when incompletely editing a pet" do
    click_link "Update #{@penny.name}"

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Peewee"
    fill_in :description, with: ""
    fill_in :age, with: ""
    select 'F', :from => :sex

    click_button "Update #{@penny.name}"
    expect(page).to have_content("Age can't be blank and Description can't be blank")
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}/edit")
  end

  it "shows a flash message when the age entered is not valid" do
    click_link "Update #{@penny.name}"

    fill_in :image, with: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg'
    fill_in :name, with: "Cracky"
    fill_in :description, with: "smart"
    fill_in :age, with: "-3"
    select 'F', :from => :sex

    click_button "Update #{@penny.name}"
    expect(page).to have_content("You must enter a positive value for the age")
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}/edit")
    visit "/shelters/#{@shelter.id}/pets"
    expect(page).to_not have_content("Cracky")
  end
  
end
