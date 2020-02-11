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
     shelter = Shelter.create(shelter_params)
    if shelter.valid?
      flash[:notice] = "You've successfully created a shelter."
      redirect_to '/shelters'
    else
      flash[:error] = "#{shelter.errors.full_messages.to_sentence}"
      redirect_to '/shelters/new'
    end
  end

  def edit
    shelter
  end

  def update
    shelter_1 = shelter
    shelter_1.update(shelter_params)
    if shelter_1.save
      flash[:notice] = "You've successfully edited this shelter."
      redirect_to "/shelters/#{shelter_1.id}"
    else
      flash[:error] = "#{shelter_1.errors.full_messages.to_sentence}"
      redirect_to "/shelters/#{shelter_1.id}/edit"
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end


  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip).to_h
  end

  def shelter
    @shelter = Shelter.find(params[:id])
  end
end
