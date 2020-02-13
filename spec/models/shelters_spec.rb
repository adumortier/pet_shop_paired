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

  it "can calculate count of pets" do

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

    expect(shelter_1.pet_count).to eq(2)
  end

  it "can show average review for shelter" do
    shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    review_1 = shelter_1.reviews.create(title: "Bad shelter", rating: 3, content: "It had fleas")
    review_2 = shelter_1.reviews.create(title: "Great shelter", rating: 1, content: "It had fleas")

    expect(shelter_1.average_review).to eq(2.0)
  end

  it "can show the number of applications at this shelter" do
    shelter_1 = Shelter.create!(name: "Abby's Shelter", address: "123 Maine Street", city: "Denver", state: "CO", zip: "80210")
    shelter_2 = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")

    pet_1 = shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Penny",
        age: 2,
        sex: "F",
        description: "Nice dog"
        )


    pet_2 = shelter_2.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Big Guy",
        age: 2,
        sex: "M",
        description: "Mean dog"
        )

    pet_3 = shelter_1.pets.create!(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Mary",
        age: 6,
        sex: "F",
        description: "Cool dog"
    )

    owner_info1 = {  :name => 'Alex',
                    :address => '123 Maine Ave',
                    :city => 'Paris',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020720',
                    :description => 'I will be a good pet owner, trust me.'}
    owner_info2 = {  :name => 'Karl',
                    :address => '123 Market St',
                    :city => 'Bangor',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020890',
                    :description => 'I will be a good pet owner, trust me.'}
    owner_info3 = {  :name => 'Phil',
                    :address => '123 Blake Ave',
                    :city => 'Denver',
                    :state => 'CO',
                    :zip => '80210',
                    :phone_number => '2077020234',
                    :description => 'I will be a good pet owner, trust me.'}

    application1 = pet_1.applications.create(owner_info1)
    application2 = pet_1.applications.create(owner_info2)
    application3 = pet_1.applications.create(owner_info3)
    application4 = pet_2.applications.create(owner_info1)
    application5 = pet_2.applications.create(owner_info2)
    application6 = pet_3.applications.create(owner_info3)

    expect(shelter_1.number_applications).to eq(4)
  end
end
