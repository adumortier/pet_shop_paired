class Favorite
  attr_reader :pets

  def initialize(pets = {})
    @pets = pets
  end

  def add_pet(id)
    @pets[id] = 0
  end

  def favorite_count
    @pets.count
  end

  def selected_pets
    Pet.find(@pets.keys)
  end

  def remove_pet_id(pet_id)
    @pets.delete(pet_id)
  end

  def remove_all
    @pets.clear
  end
end
