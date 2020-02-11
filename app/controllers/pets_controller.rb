class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
    # require "pry"; binding.pry
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    if pet.valid?
      redirect_to "/shelters/#{shelter.id}/pets"
    else
      flash[:error] = "#{pet.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    pet = Pet.find(params[:pet_id])
    if pet.update(pet_params)
      redirect_to "/shelters/#{shelter.id}/pets/#{pet.id}"
    else
      flash[:error] = "#{pet.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter.id}/pets/#{pet.id}/edit"
    end
  end

  def destroy
    favorites.remove_pet_id(params[:pet_id])
    shelter = Shelter.find(params[:shelter_id])
    Pet.destroy(params[:pet_id])
    redirect_to "/shelters/#{shelter.id}/pets"
  end


  private

  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adopted?, :shelter_id)
  end
end
