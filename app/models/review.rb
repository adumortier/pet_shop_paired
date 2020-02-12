class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content, :image

  belongs_to :shelter

  def self.valid_rating?(score)
    (score.to_i > 0) &&  (score.to_i < 6)
  end
end
