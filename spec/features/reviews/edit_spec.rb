# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create(name: "Alex's Shelter", address: '123 Maine Street', city: 'Denver', state: 'CO', zip: '80210')
    @review_1 = @shelter_1.reviews.create(title: 'Good shelter', rating: 5, content: 'It was a great shelter', image: 'https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg')
    @review_2 = @shelter_1.reviews.create(title: 'Okay shelter', rating: 3, content: 'It was an okay shelter', image: 'https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg')

    visit "/shelters/#{@shelter_1.id}"
  end

  it 'can click link to edit a review from shelter show page' do
    click_link "Edit #{@review_1.title}"
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")

    fill_in :title, with: 'Amazing Shelter'

    click_on 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content('Amazing Shelter')
    expect(page).to_not have_content('Good Shelter')
  end

  it 'shows flash message for submission success' do
    visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

    fill_in :title, with: 'Good shelter'
    select 5, :from => :rating
    fill_in :content, with: 'teeee'
    fill_in :image, with: 'https://www.rd.com/wp-content/uploads/2017/11/05-amazon-9-Powerful-Ways-to-Give-to-Charity-Without-Breaking-the-Bank_527124532-Pongsatorn-Singnoy-800x450.jpg'

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content('Review successfully updated!')
  end

  it 'shows flash message for submission failure' do
    visit "/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit"

    fill_in :title, with: 'Good shelter'
    select 5, :from => :rating
    fill_in :content, with: ''
    fill_in :image, with: 'https://www.rd.com/wp-content/uploads/2017/11/05-amazon-9-Powerful-Ways-to-Give-to-Charity-Without-Breaking-the-Bank_527124532-Pongsatorn-Singnoy-800x450.jpg'

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@review_1.id}/edit")
    expect(page).to have_content('Please enter all required information')
  end
end
