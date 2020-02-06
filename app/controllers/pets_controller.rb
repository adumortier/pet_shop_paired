class PetsController < ApplicationController

  def index
    @pets = Pet.all
    # @favorite = Favorite.new(session[:fav_pets])
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    shelter.pets.create(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets"
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
    pet.update(pet_params)
    redirect_to "/shelters/#{shelter.id}/pets/#{pet.id}"
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    Pet.destroy(params[:pet_id])
    redirect_to "/shelters/#{shelter.id}/pets"
  end


  private

  def pet_params
    params.permit(:image, :name, :age, :sex, :description, :adopted?, :shelter_id)
  end
end
