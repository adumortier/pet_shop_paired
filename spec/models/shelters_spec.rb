require 'rails_helper'

describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  it "instance methods" do

    shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")

    pet_1 = shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )

    pet_2 = shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Big Guy",
        age: 2,
        sex: "M",
        description: "Mean dog"
        )

    owner_info1 = {  :name => 'Alex',
                    :address => '123 Maine Ave',
                    :city => 'Paris',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020720',
                    :description => 'I will be a good pet owner, trust me.'}

    application1 = pet_1.applications.create(owner_info1)

    expect(shelter_1.approved_pet?).to eq(false)
    pet_1.update(adopted?: "Pending")
    expect(shelter_1.approved_pet?).to eq(true)
  end

  it "can return a string that contains the empty fields" do
    shelter_param = {"name"=>"", "address"=>"456 Dublin St", "city"=>"Phoenix", "state"=>"AZ", "zip"=>""}
    output = Shelter.empty_params(shelter_param)
    expect(output).to eq("name, zip")
  end
end
