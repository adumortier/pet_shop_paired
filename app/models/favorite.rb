class Favorite
  attr_reader :pets

  def initialize(pets)
    @pets = pets || Hash.new(0)
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

  def update_favorites(ids)
    ids.each do |id|
      remove_pet_id(id)
    end
  end
end
