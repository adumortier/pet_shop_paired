# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '#favorite_count' do
  it 'can count the number of pets added as favorite' do
    session_info = { '1' => { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' } }
    favorites1 = Favorite.new(session_info)
    expect(favorites1.favorite_count).to eq 1
    session_info['2'] = { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
    favorites2 = Favorite.new(session_info)
    expect(favorites2.favorite_count).to eq 2
  end

  it 'can add a pet to its favorites' do
    info1 = { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' }
    info2 = { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
    favorites1 = Favorite.new('1' => info1)
    favorites1.add_favorite('2' => info2) # braces automatically removed
    expected = {
      '1' => { 'name' => 'Penny', 'image' => 'https://s3.amazonaws.com/cdn-origin.jpg' },
      '2' => { 'name' => 'Paulie', 'image' => 'https://s3.amazonaws.com/cdn-origin1.jpg' }
    }
    expect(favorites.pets).to eq(expected)
  end
end
