class FavoriteController < ApplicationController

  def update
    # favorites.add_pet(params[:id])
    # pet = Pet.find(params[:id])

    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:fav_pets] ||= Hash.new(0)
    session[:fav_pets][pet_id_str] ||= {}
    
    flash[:notice] = "You added #{pet.name} to your favorites."
    redirect_to '/pets'
  end
end
