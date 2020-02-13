require 'rails_helper'

RSpec.describe "As a visitor" do

  before :each do
    Shelter.destroy_all
    Pet.destroy_all

    @shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @shelter_2 = Shelter.create!(name: "Alex's Shelter", address: "123 Maine Street", city: "Bangor", state: "ME", zip: "04401")

    @review_1 = @shelter_2.reviews.create(title: "Bad shelter", rating: 1, content: "It had fleas")
    @review_2 = @shelter_1.reviews.create(title: "Great shelter", rating: 1, content: "It had fleas")

    @pet_1 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )

    @pet_2 = @shelter_2.pets.create!(
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

    @application1 = @pet_1.applications.create(@owner_info1)

    visit "/applications/#{@application1.id}"

    within("span#pet_#{@pet_1.id}") do
      click_link "Approve Application"
    end
  end

  it "cannot delete shelter with approved pet from shelter show page" do
    visit "/shelters/#{@shelter_1.id}"
    expect(page).to_not have_content("Delete #{@shelter_1.name}")
  end

  it "cannot delete shelter with approved pet from shelter index page" do
    visit "/shelters"
    expect(page).to_not have_content("Delete #{@shelter_1.name}")
  end

  it "can delete a shelter when no pets have a pending status" do
    visit "/shelters"
      within("#shelter-#{@shelter_2.id}") do
        click_link "Delete #{@shelter_2.name}"
      end

      expect(page).to_not have_content(@shelter_2.address)
      expect(page).to_not have_content(@shelter_2.city)
      expect(page).to_not have_content(@shelter_2.state)
      expect(page).to_not have_content(@shelter_2.zip)

      visit "/pets"

      expect(page).to_not have_content(@pet_2.name)
  end

  it "deletes the reviews for the shelter when the shelter is deleted" do
    reviews_count = Review.count
    expect(reviews_count).to eq(2)

    visit "/shelters"
      within("#shelter-#{@shelter_2.id}") do
        click_link "Delete #{@shelter_2.name}"
      end

    reviews_count = Review.count
    expect(reviews_count).to eq(1)

    review = Review.first
    expect(review).to_not have_content("Bad shelter")
  end
end
