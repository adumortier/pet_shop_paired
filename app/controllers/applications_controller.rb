class ApplicationsController < ApplicationController

  def new
  end

  def show 
    @application = Application.find(params[:id])
  end

  # def create
  #   if !params[:pet_ids].nil? 
  #     params[:pet_ids].each do |pet_id|
  #       pet = Pet.find(pet_id)
  #       if pet.applications.create(favorites_params).valid?
  #         flash[:notice] = 'Your Application has been submitted successfully!'
  #         favorites.update_favorites(params[:pet_ids])
  #       else
  #         flash[:notice] = 'You must complete the form in order to submit the application'
  #         redirect_to "/applications/new"
  #         return
  #       end
  #     end
  #     redirect_to "/favorites"
  #   else
  #     flash[:notice] = 'You must complete the form in order to submit the application'
  #     redirect_to "/applications/new"
  #   end
  # end

    def create
      if !params[:pet_ids].nil? 
        application = Application.create(favorites_params)
        if (application.valid?)
          flash[:notice] = 'Your Application has been submitted successfully!'
          favorites.update_favorites(params[:pet_ids])
          params[:pet_ids].each do |pet_id|
            pet = Pet.find(pet_id)
            application.pets << pet 
          end
          redirect_to "/favorites" 
        else
          flash[:notice] = 'You must complete the form in order to submit the application'
          redirect_to "/applications/new"
          return
        end
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