class ShelterPetsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
    # @shelter_pets = @shelter.pets
  end
end
