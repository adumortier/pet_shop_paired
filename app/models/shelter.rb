class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  has_many :pets, :dependent => :destroy
  has_many :reviews, :dependent => :destroy  #why is this here and not on reviews?

  def approved_pet?
    pets.where(adopted?: "Pending").empty? == false
  end

  def self.empty_params(shelter_param)
  shelter_param.reduce([]) do |acc, param|
      if param[1] == ""
        acc << param[0]
      end
      acc
    end.join(", ")
  end

  def pet_count
    pets.count
  end

  def average_review
    reviews.average(:rating).to_f
  end

  # def number_applications
  #   require "pry"; binding.pry
  # end
end
