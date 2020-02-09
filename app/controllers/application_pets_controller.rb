class ApplicationPetsController < ApplicationController

  def index 
    pet = Pet.find(params[:pet_id])
    @applications = pet.applications
  end

end
