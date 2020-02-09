class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets, :dependent => :destroy
  has_many :reviews, :dependent => :destroy  #why is this here and not on reviews?


  def approved_pet?
    pets.where(adopted?: "Pending").empty? == false
  end
end
