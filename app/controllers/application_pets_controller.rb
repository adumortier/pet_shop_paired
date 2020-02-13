class ApplicationPetsController < ApplicationController

  def index
    pet = Pet.find(params[:pet_id])
    @applications = pet.applications
  end

  def update
    pet = Pet.find(params[:pet_id])
    if pet.adopted? == "Adoptable"
      pet.update(adopted?: "Pending", adopter: params[:app_id].to_i)
      flash[:approved] = 'Application Approved.'
      redirect_to "/pets/#{pet.id}"
    else
      pet.update(adopted?: "Adoptable", adopter: nil)
      redirect_to "/applications/#{params[:app_id]}" 
    end  
  end

  def batch_update
    pet_ids = params[:pet_ids]
    pet_ids.each do |id|
      pet = Pet.find(id)
      if pet.adopted? == "Adoptable"
        pet.update(adopted?: "Pending", adopter: params[:app_id].to_i)
        flash[:approved] = "#{pet.name}'s application was approved."
      else
        pet.update(adopted?: "Adoptable", adopter: nil)
      end  
    end
    redirect_to "/pets"
  end
end
