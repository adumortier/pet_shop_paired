class ApplicationPetsController < ApplicationController

  def index 
    pet = Pet.find(params[:pet_id])
    @applications = pet.applications
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet.update(adopted?: "Pending")
    redirect_to "/pets/#{pet.id}"
  end

end
