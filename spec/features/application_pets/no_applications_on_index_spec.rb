require 'rails_helper'
RSpec.describe 'As a visitor' do
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
    @owner_info2 = { :name => 'Mike',
                    :address => '476 Market street',
                    :city => 'Denver',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '4737020720',
                    :description => "I loved pets, I'll do my best"}

    visit "/pets/#{@pet_1.id}/applications"
  end
  
  it "When there are no applications on a pet and I visit the index page there is text telling me as such" do
    expect(page).to have_content("This pet has no applications at this time.")
  end
end
