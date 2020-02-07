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

end
