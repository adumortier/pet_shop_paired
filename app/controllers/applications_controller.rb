class ApplicationsController < ApplicationController

  def new
  end

  def create 
    flash[:notice] = 'Your Application has been submitted successfully!'
    favorites.update_favorites(params[:pet_ids])
    redirect_to "/favorites"
  end


end