require 'rails_helper'

RSpec.describe 'When a user clicks the submit button', type: :feature do
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

    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit "/pets/#{@pet_2.id}"
    click_link "Add to Favorites"

    visit "/favorites"

    click_link "Adopt your favorite pets!"
    expect(current_path).to eq('/applications/new')
  
    @owner_info = {  :name => 'Alex', 
                    :address => '123 Maine Ave', 
                    :city => 'Paris', 
                    :state => 'CO', 
                    :zip => '80210', 
                    :phone_number => '2077020720', 
                    :description => 'I will be a good pet owner, trust me.'}
    # check_box_tag where you select pet(s), select one pet for now (@pet_1) to make sure the other is left on /favorites
    within("span#pet_#{@pet_1.id}") do
      check "pet_ids_"
    end

  end
  
  it 'you can apply for a pet that will then remove that pet from the favorites page' do
    
    fill_in 'Name', with: @owner_info[:name]
    fill_in 'Address', with: @owner_info[:address]
    fill_in 'City', with: @owner_info[:city]
    fill_in 'State', with: @owner_info[:state]
    fill_in 'Zip', with: @owner_info[:zip]
    fill_in 'Phone number', with: @owner_info[:phone_number]
    fill_in 'Description', with: @owner_info[:description]
  
    click_button 'Submit Application'

    expect(page).to have_content('Your Application has been submitted successfully!') #flash message
    expect(current_path).to eq('/favorites')
    expect(page).to have_css("img[src*='#{@pet_2.image}']")
    expect(page).to_not have_css("img[src*='#{@pet_1.image}']")
  end

  it "redirects the user to the application form when fields are missing" do 
    fill_in 'Name', with: ""
    fill_in 'Address', with: @owner_info[:address]
    fill_in 'City', with: @owner_info[:city]
    fill_in 'State', with: @owner_info[:state]
    fill_in 'Zip', with: @owner_info[:zip]
    fill_in 'Phone number', with: @owner_info[:phone_number]
    fill_in 'Description', with: @owner_info[:description]
  
    click_button 'Submit Application'

    expect(page).to have_content('You must complete the form in order to submit the application') #flash message
    expect(current_path).to eq('/applications/new')
  end

  it "the favorites index page shows a list of pets that have at least one application" do

    within("span#pet_#{@pet_2.id}") do
      check "pet_ids_"
    end

    fill_in 'Name', with: @owner_info[:name]
    fill_in 'Address', with: @owner_info[:address]
    fill_in 'City', with: @owner_info[:city]
    fill_in 'State', with: @owner_info[:state]
    fill_in 'Zip', with: @owner_info[:zip]
    fill_in 'Phone number', with: @owner_info[:phone_number]
    fill_in 'Description', with: @owner_info[:description]

    click_button 'Submit Application'

    visit "/favorites"

    within("div#pending_pets") do
      expect(page).to have_content("#{@pet_1.name}") 
      expect(page).to have_content("#{@pet_2.name}") 
      click_link "#{@pet_1.name}"
      expect(page).to have_current_path("/pets/#{@pet_1.id}")
    end

    visit "/favorites"

    within("div#pending_pets") do
      expect(page).to have_content("#{@pet_1.name}") 
      expect(page).to have_content("#{@pet_2.name}") 
      click_link "#{@pet_2.name}"
      expect(page).to have_current_path("/pets/#{@pet_2.id}")
    end

  end
end

#   User Story 18, List of Pets that have applications on them

# As a visitor
# After one or more applications have been created
# When I visit the favorites index page
# I see a section on the page that has a list of all of the pets that have at least one application on them
# Each pet's name is a link to their show page



# User Story 17, Incomplete application for a Pet

# As a visitor
# When I apply for a pet and fail to fill out any of the following:
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I'm redirect back to the new application form to complete the necessary fields
# And I see a flash message indicating that I must complete the form in order to submit the application

# User Story 16, Applying for a Pet

# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
