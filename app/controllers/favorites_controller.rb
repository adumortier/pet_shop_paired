class FavoritesController < ApplicationController

  def index
    pets_id = ApplicationPet.pluck(:pet_id)
    @pending_pets = Pet.where(id: pets_id)
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:fav_pets] ||= Hash.new(0)
    session[:fav_pets][pet_id_str] ||= {}

    flash[:notice] = "You added #{pet.name} to your favorites."
    redirect_to '/pets'
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet_id(params[:pet_id])
    flash[:notice] = "#{pet.name} Removed from Favorites"
    # redirect_to "/pets/#{params[:pet_id]}"
    redirect_back fallback_location: '/pets'
  end

  def destroy_all
    favorites.remove_all
    redirect_to '/favorites'
  end
end
