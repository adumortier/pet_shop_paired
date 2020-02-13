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
  end
end
