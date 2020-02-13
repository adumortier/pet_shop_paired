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

  end

  it 'you can apply for a pet that will then remove that pet from the favorites page' do

    within("span#pet_#{@pet_1.id}") do
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

    expect(page).to have_content('Your Application has been submitted successfully!') #flash message
    expect(current_path).to eq('/favorites')
    expect(page).to have_css("img[src*='#{@pet_2.image}']")
    expect(page).to_not have_css("img[src*='#{@pet_1.image}']")
  end

  it "redirects the user to the application form when fields are missing" do

    within("span#pet_#{@pet_1.id}") do
      check "pet_ids_"
    end

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

    within("span#pet_#{@pet_1.id}") do
      check "pet_ids_"
    end

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

  it "shows a flash message if not pets where selected for an application" do

    fill_in 'Name', with: @owner_info[:name]
    fill_in 'Address', with: @owner_info[:address]
    fill_in 'City', with: @owner_info[:city]
    fill_in 'State', with: @owner_info[:state]
    fill_in 'Zip', with: @owner_info[:zip]
    fill_in 'Phone number', with: @owner_info[:phone_number]
    fill_in 'Description', with: @owner_info[:description]

    click_button 'Submit Application'
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("You must complete the form in order to submit the application")
  end
end
