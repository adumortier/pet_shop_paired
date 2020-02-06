# frozen_string_literal: true

RSpec.describe 'As a visitor' do
  before :each do
    @shelter_1 = Shelter.create!(name: "Abby's Shelter", address: '123 Maine Street', city: 'Denver', state: 'CO', zip: '80210')
    @pet1 = shelter1.pets.create!(
      image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
      name: 'Penny',
      age: 2,
      sex: 'F'
    )
    @pet2 = shelter1.pets.create!(
      image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
      name: 'Paulie',
      age: 3,
      sex: 'F'
    )
  end

  it 'has a favorite indicator in the nav bar' do
    visit '/shelters'
    expect(page).to have_link('Favorites')
  end

  it 'shows the count of pets in my favorites list' do
    visit '/pets'
    within("span#{pet1.id}")
    click_link 'Add to Favorites'
  end
  expect(page)
end
