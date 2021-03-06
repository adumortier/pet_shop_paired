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
    @owner_info = {  :name => 'Alex',
                    :address => '123 Maine Ave',
                    :city => 'Paris',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020720',
                    :description => 'I will be a good pet owner, trust me.'}
    @application = @pet_1.applications.create(@owner_info)

  end

  it "the application show page displays the application information" do

    visit "/applications/#{@application.id}"
    expect(page).to have_content("Name: #{@application.name}")
    expect(page).to have_content("Address: #{@application.address}")
    expect(page).to have_content("City: #{@application.city}")
    expect(page).to have_content("State: #{@application.state}")
    expect(page).to have_content("Zip: #{@application.zip}")
    expect(page).to have_content("Phone number: #{@application.phone_number}")
    expect(page).to have_content("Description: #{@application.description}")
    click_link "#{@pet_1.name}"
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end
end
