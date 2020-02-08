require 'rails_helper'

RSpec.describe '#favorite_count' do
  # it 'can count the number of pets added as favorite' do
  #   session_info = { '1' => { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' } }
  #   favorites1 = Favorite.new(session_info)
  #   expect(favorites1.favorite_count).to eq 1
  #   session_info['2'] = { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
  #   favorites2 = Favorite.new(session_info)
  #   expect(favorites2.favorite_count).to eq 2
  # end
  #
  # it 'can add a pet to its favorites' do
  #   info1 = { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' }
  #   info2 = { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
  #   favorites1 = Favorite.new('1' => info1)
  #   favorites1.add_favorite('2' => info2) # braces automatically removed
  #   expected = {
  #     '1' => { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' },
  #     '2' => { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
  #   }
  #   expect(favorites.pets).to eq(expected)
  # end

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
