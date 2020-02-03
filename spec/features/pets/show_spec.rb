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
      description: "Very fun dog",
      )

    @shelter.pets << @penny

    visit "/pets/#{@penny.id}"
  end

  it "shows the pets information on their show page and link for a new pet" do

    expect(page).to have_css("img[src*='#{@penny.image}']")
    expect(page).to have_content(@penny.name)
    expect(page).to have_content(@penny.age)
    expect(page).to have_content(@penny.sex)
    expect(page).to have_content(@penny.description)
    expect(page).to have_content("Adopt me!")
  end
end
