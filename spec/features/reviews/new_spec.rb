# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    Shelter.destroy_all
    Review.destroy_all

    @shelter_1 = Shelter.create(name: "Alex's Shelter", address: '123 Maine Street', city: 'Denver', state: 'CO', zip: '80210')
    @shelter_2 = Shelter.create(name: "Other Alex's Shelter", address: '456 Maine Street', city: 'Paris', state: 'FR', zip: '80327')
  end

  it 'has a link to create a review and a form to enter review information' do
    visit "/shelters/#{@shelter_1.id}"
    click_link 'New Review'

    expect(page).to have_current_path("/shelters/#{@shelter_1.id}/reviews/new")

    expect(page).to have_content('Title')
    expect(page).to have_content('Rating')
    expect(page).to have_content('Content')
    expect(page).to have_content('Image')

    fill_in :title, with: 'Good shelter'
    select 5, :from => :rating
    fill_in :content, with: 'It was a great shelter'
    fill_in :image, with: 'https://www.rd.com/wp-content/uploads/2017/11/05-amazon-9-Powerful-Ways-to-Give-to-Charity-Without-Breaking-the-Bank_527124532-Pongsatorn-Singnoy-800x450.jpg'

    click_button 'Submit'
    expect(page).to have_current_path("/shelters/#{@shelter_1.id}")
    expect(page).to have_content('Title: Good shelter')
    expect(page).to have_content('Content: It was a great shelter')
  end

  it "does not save new review without all the information" do

    visit "/shelters/#{@shelter_2.id}/reviews/new"

    fill_in :title, with: 'Good shelter'
    select 5, :from => :rating

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_2.id}/reviews/new")
    expect(page).to have_content("Failed to fill out require information.")

    fill_in :title, with: 'Bad shelter'
    select 2, :from => :rating
    fill_in :content, with: 'It was a bad shelter'
    fill_in :image, with: 'https://www.rd.com/wp-content/uploads/2017/11/05-amazon-9-Powerful-Ways-to-Give-to-Charity-Without-Breaking-the-Bank_527124532-Pongsatorn-Singnoy-800x450.jpg'

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_2.id}")
    expect(page).to have_content("Review successfully submitted!")
  end
end
