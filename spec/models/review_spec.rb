require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    it {should validate_presence_of :image}
  end

  describe "relationships" do
    it {should belong_to :shelter}
  end

  describe "methods" do
    it "can check that a rating is valid" do

      rating1 = 4
      expect(Review.valid_rating?(rating1)).to eq(true)

      rating2 = -3
      expect(Review.valid_rating?(rating2)).to eq(false)

      rating3 = 6
      expect(Review.valid_rating?(rating3)).to eq(false)
    end
  end
end
