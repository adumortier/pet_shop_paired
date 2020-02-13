require 'rails_helper'

RSpec.describe '#favorite_count' do

  it "use instance methods " do
    pet_ids = {"5" => 0, "6" => 0}
    @favorite = Favorite.new(pet_ids)

    expect(@favorite.pets).to eq(pet_ids)
    @favorite.remove_pet_id("6")
    expect(@favorite.pets).to eq({"5" => 0})
  end

  it "can remove all favorites at once" do
    pet_ids = {"5" => 0, "6" => 0}
    @favorite = Favorite.new(pet_ids)

    @favorite.remove_all
    expect(@favorite.pets).to eq({})
  end

  it 'can update the list of favorite pets after application is submitted' do
    pet_ids = {"5" => 0, "6" => 0, "7" => 0}
    @favorite = Favorite.new(pet_ids)
    ids = ["5", "6"]
    @favorite.update_favorites(ids)
    expect(@favorite.pets).to eq({"7" => 0})
  end
end
