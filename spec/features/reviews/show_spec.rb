require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Alex's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    @review_1 = @shelter_1.reviews.create(title: "Good shelter", rating: 5, content: "It was a great shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")
    @review_2 = @shelter_1.reviews.create(title: "Okay shelter", rating: 3, content: "It was an okay shelter", image: "https://i.pinimg.com/originals/d1/21/f6/d121f64f59f7599486e3762fcd2f1475.jpg")

    visit "/shelters/#{@shelter_1.id}"
  end

  it "has a list of reviews on the shelter show page" do

    expect(page).to have_content(@review_1.title)
    expect(page).to have_content(@review_1.rating)
    expect(page).to have_content(@review_1.content)

    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_2.rating)
    expect(page).to have_content(@review_2.content)
  end
end
