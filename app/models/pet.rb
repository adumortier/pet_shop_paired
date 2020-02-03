class Pet < ApplicationRecord
  validates_presence_of :image, :name, :age, :sex

  belongs_to :shelter

  def adoption_status
      if adopted?
        "Adopt me!"
      else
        "I'm going home with someone!"
    end
  end
end
