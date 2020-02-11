require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
    @shelter_3 = Shelter.create(name: "Aaron's Shelter", address: "678 California Street", city: "Denver", state: "CO", zip: "80234")

    @pet_1 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )

    @pet_2 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Rufus",
        age: 2,
        sex: "M",
        description: "Big dog"
        )

    @owner_info1 = {  :name => 'Alex',
                    :address => '123 Maine Ave',
                    :city => 'Paris',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020720',
                    :description => 'I will be a good pet owner, trust me.'}

    @owner_info2 = { :name => 'Mike',
                    :address => '476 Market street',
                    :city => 'Denver',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '4737020720',
                    :description => "I loved pets, I'll do my best"}

    @application1 = @pet_1.applications.create(@owner_info1)
    @application2 = @pet_2.applications.create(@owner_info2)

    @review_1 = @shelter_1.reviews.create(title: "Good shelter", rating: 5, content: "It was a great shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")
    @review_2 = @shelter_1.reviews.create(title: "Okay shelter", rating: 3, content: "It was an okay shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")
    @review_3 = @shelter_1.reviews.create(title: "Fine shelter", rating: 3, content: "It was a fine shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")
    @review_4 = @shelter_1.reviews.create(title: "Decent shelter", rating: 5, content: "It was a decent shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")
    @review_5 = @shelter_1.reviews.create(title: "Cool shelter", rating: 4, content: "It was a cool shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "shows a shelter's information from their show page" do

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "has a link to update the a shelter" do

    expect(page).to have_link "Update #{@shelter_1.name}"
    click_link "Update #{@shelter_1.name}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it "shows link to shelter's pets" do

    expect(page).to have_link("Current Pets")
  end

  it "has statistics for the shelter" do

    expect(page).to have_content("Shelter Pet Count: 2")
    expect(page).to have_content("Average Shelter Review: 4")
    expect(page).to have_content("Number of Applications: 2")
    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_content("Number of Applications: 0")

  end
end
#
# User Story 30, Shelter Statistics
#
# As a visitor
# When I visit a shelter's show page
# I see statistics for that shelter, including:
# - count of pets that are at that shelter
# - average shelter review rating
# - number of applications on file for that shelter
