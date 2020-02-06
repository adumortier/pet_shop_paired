class FavoriteController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:fav_pets] ||= Hash.new()
    session[:fav_pets][pet_id_str] ||= 0
    require "pry"; binding.pry
    flash[:notice] = "You added #{pet.name} to your favorites."
    redirect_to '/pets'
  end
end
