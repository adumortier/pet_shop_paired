class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    new_review = shelter.reviews.create(review_params)
    if new_review.save
      flash[:happy] = "Review successfully submitted!"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:sad] = "Failed to fill out require information."
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image)
  end
end
