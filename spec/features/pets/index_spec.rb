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
      description: "huge"
      )
    @paulie = Pet.create(
      image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
      name: "Paulie",
      age: 3,
      sex: "F",
      description: "huge"
      )

    @shelter.pets << [@penny, @paulie]

    visit "/pets"
  end

  it "shows all the pets" do

    expect(page).to have_css("img[src*='#{@penny.image}']")
    expect(page).to have_content(@penny.name)
    expect(page).to have_content(@penny.age)
    expect(page).to have_content(@penny.sex)
    expect(page).to have_content(@penny.shelter.name)
  end

  it "has a link to edit next to every pet" do
    within "#pets-#{@penny.id}" do
      expect(page).to have_link("Edit #{@penny.name}")
      click_link "Edit #{@penny.name}"
      expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}/edit")
    end
  end

  it "has a link to delete next to every pet" do
    within "#pets-#{@penny.id}" do
      expect(page).to have_link("Delete #{@penny.name}")
      click_link "Delete #{@penny.name}"
    end
    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to_not have_content("Penny")
  end

  it "has edit and delete links next to all pets that belong to a shelter" do
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
      description: "huge"
      )
    @paulie = Pet.create(
      image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
      name: "Paulie",
      age: 3,
      sex: "F",
      description: "huge"
      )

    @shelter.pets << [@penny, @paulie]

    visit "/shelters/#{@shelter.id}/pets"

    within "#pets-#{@penny.id}" do
      expect(page).to have_link("Edit #{@penny.name}")
      click_link "Edit #{@penny.name}"
      expect(current_path).to eq("/shelters/#{@shelter.id}/pets/#{@penny.id}/edit")
    end
  end

  it "has a link to delete next to every pet" do

    visit "/shelters/#{@shelter.id}/pets"

    within "#pets-#{@penny.id}" do
      expect(page).to have_link("Delete #{@penny.name}")
      click_link "Delete #{@penny.name}"
    end

    expect(current_path).to eq("/shelters/#{@shelter.id}/pets")
    expect(page).to_not have_content("Penny")
  end
end
