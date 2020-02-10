class SheltersController < ApplicationController

  def index
    @shelters = Shelter.all
  end

  def show
    shelter
  end

  def new
  end

  def create
    # Shelter.create(shelter_params)
    if Shelter.create(shelter_params).valid?
      flash[:notice] = "You've successfully created a shelter."
      redirect_to '/shelters'
    else   
      flash[:notice] = "All fields are required to submit a new shelter."
      redirect_to '/shelters/new'
    end
  end

  def edit
    shelter
  end
  
  def update
    # shelter.update(shelter_params)
    # redirect_to "/shelters/#{shelter.id}"
    if shelter.update(shelter_params)
      flash[:notice] = "You've successfully edited this shelter."
      redirect_to "/shelters/#{shelter.id}"
    else   
      flash[:notice] = "All fields are required to update a shelter."
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end


  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def shelter
    @shelter = Shelter.find(params[:id])
  end
end
