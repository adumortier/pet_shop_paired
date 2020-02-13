class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets, :dependent => :destroy
  has_many :reviews, :dependent => :destroy  #why is this here and not on reviews?

  def approved_pet?
    pets.where(adopted?: "Pending").empty? == false
  end

  def pet_count
    pets.count
  end

  def average_review
    reviews.average(:rating).to_f
  end

  def number_applications
      pets.joins(:applications).select('applications.*').distinct.count
    # ApplicationPet.joins('JOIN pets on application_pets.pet_id = pets.id').joins('JOIN shelters on shelters.id = pets.shelter_id').where("shelters.id = #{id}").count
  end
  
end
