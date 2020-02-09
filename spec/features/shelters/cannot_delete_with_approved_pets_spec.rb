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
end
