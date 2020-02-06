class Favorite
  attr_reader :pets

  def initialize(pets = {})
    @pets = pets
    # require "pry"; binding.pry
  end

  def favorite_count
    # require "pry"; binding.pry
    session[:fav_pets].count
    # @pets.count do |pet_id, status|
    #   status == true
    # end
  end


end
