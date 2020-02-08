class ApplicationsController < ApplicationController

  def new
  end

  def create 
    application = Application.new(favorites_params)
    if (application.save) && (!params[:pet_ids].nil?)
      flash[:notice] = 'Your Application has been submitted successfully!'
      favorites.update_favorites(params[:pet_ids])
      redirect_to "/favorites"
    else 
      flash[:notice] = 'You must complete the form in order to submit the application'
      redirect_to "/applications/new"
    end
  end

  private 

  def favorites_params 
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

end