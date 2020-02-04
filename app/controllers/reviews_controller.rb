# frozen_string_literal: true

class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    new_review = shelter.reviews.create(review_params)
    if new_review.save
      flash[:happy] = 'Review successfully submitted!'
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:sad] = 'Failed to fill out require information.'
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.find(params[:review_id])
    review.update(review_params)
    if review.save
      flash[:happy] = 'Review successfully updated!'
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:sad] = 'Please enter all required information'
      redirect_to "/shelters/#{shelter.id}/reviews/#{review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:review_id])
    review.destroy
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

  def review_params
    params.permit(:title, :content, :rating, :image)
  end
end
