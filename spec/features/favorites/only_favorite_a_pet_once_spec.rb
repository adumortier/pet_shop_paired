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
      @pet_2 = @shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Paulie",
        age: 3,
        sex: "F",
        description: "Good dog"
        )

    visit "/pets"
  end

  it "favorites a pet" do

      within("#pets-#{@pet_1.id}") do
        click_link "Add to Favorites"
      end

      within("#pets-#{@pet_2.id}") do
        click_link "Add to Favorites"
      end

      within("#nav") do
      expect(page).to have_content("2")
    end

    visit "/pets/#{@pet_1.id}"

    expect(page).to_not have_link("Add to Favorites")
    expect(page).to have_link("Remove #{@pet_1.name} from Favorites")

    click_link "Remove #{@pet_1.name} from Favorites"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} Removed from Favorites")
    expect(page).to have_content("Add to Favorites")

      within("#nav") do
      expect(page).to have_content("1")
    end
  end
end


# <% if @favorites.include?(@pet.id.to_s) %>
#   <%= button_to 'Remove Favorite', "/favorites/#{@pet.id}", method: :delete %>
# <% else %>
#   <%= button_to 'Favorite', "/favorites/#{@pet.id}", method: :patch %>
# <% end %>


# User Story 12, Can't Favorite a Pet More Than Once

# After I've favorited a pet
# When I visit that pet's show page
# I no longer see a link to favorite that pet
# But I see a link to remove that pet from my favorites
# When I click that link
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to that pets show page where I can see a flash message indicating that the pet was removed from my favorites
# And I can now see a link to favorite that pet
# And I also see that my favorites indicator has decremented by 1
