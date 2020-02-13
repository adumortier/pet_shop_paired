require 'rails_helper'

RSpec.describe 'When I visit an application show page', type: :feature do

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
        image: 'https://petsfeed.co/wp-content/uploads/2019/04/German-Shepherd-dog.jpg',
        name: "Paulie",
        age: 3,
        sex: "F",
        description: "Good dog"
        )

    @owner_info1 = {  :name => 'Alex',
                    :address => '123 Maine Ave',
                    :city => 'Paris',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020720',
                    :description => 'I will be a good pet owner, trust me.'}
    pets = [@pet_1, @pet_2]
    @application1  = Application.create(@owner_info1)
    @application1.pets << pets[0]
    @application1.pets << pets[1]
  end

  it "The application can be approved from the show page" do

    visit "/applications/#{@application1.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

    within("span#pet_#{@pet_1.id}") do
      click_link "Approve Application"
    end

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    expect(page).to have_content("Availability: Pending")
    expect(page).to have_content("On hold for #{@owner_info1[:name]}")

    visit "/applications/#{@application1.id}"

    within("span#pet_#{@pet_2.id}") do
      click_link "Approve Application"
    end

    expect(page).to have_current_path("/pets/#{@pet_2.id}")
    expect(page).to have_content("Availability: Pending")
    expect(page).to have_content("On hold for #{@owner_info1[:name]}")
  end
end
