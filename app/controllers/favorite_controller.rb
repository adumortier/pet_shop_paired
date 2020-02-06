# frozen_string_literal: true

class FavoriteController < ApplicationController
  def index
    # @favorites = favorites
  end

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    favorites.add_favorite(pet_id_str => { 'name' => pet.name, 'image' => pet.image }) # brackets removed automatically

    # favorites.add_favorite(pet_id_str, 'name' => pet.name, 'image' => pet.image) # brackets removed automatically
    # session[:fav_pets] ||= {}
    # session[:fav_pets][pet_id_str] ||= { name: pet.name, image: pet.image }
    flash[:notice] = "You added #{pet.name} to your favorites."
    redirect_to '/pets'
  end
end
