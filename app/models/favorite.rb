# frozen_string_literal: true

class Favorite
  attr_reader :pets

  def initialize(pets = {})
    @pets = pets
  end

  def add_favorite(info)
    pet_id = info[:id]
    pet_info = info[:info]
    @pets[pet_id] ||= pet_info
  end

  def favorite_count
    @pets.count
  end
end
