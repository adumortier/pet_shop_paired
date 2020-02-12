require 'rails_helper'

describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
  end

  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end

  describe "instance method" do
    shelter = Shelter.create(name: "Alex's Shelter", address: "345 Georgia Street", city: "Denver", state: "CO", zip: "80223")
    pet = shelter.pets.create(
        image: 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg',
        name: "Paulie",
        age: 3,
        sex: "F",
        )
    it "can say if pet is adopted when created" do
        expect(pet.adopted?).to eq("Adoptable")
    end # not sure how to / if I can check the sad path yet?
  end
end
