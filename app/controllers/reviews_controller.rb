class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    score = review_params[:rating]
    shelter = Shelter.find(params[:shelter_id])
    new_review = shelter.reviews.new(review_params)#######changed from create to new
    if new_review.save && Review.valid_rating?(score)
      flash[:happy] = 'Review successfully submitted!'
      redirect_to "/shelters/#{shelter.id}"
    else
      if !Review.valid_rating?(score)
        flash[:rating] = 'Please enter a rating between 1 and 5'
        Review.destroy(new_review.id)
        redirect_to "/shelters/#{shelter.id}/reviews/new" and return
      end
      flash[:sad] = 'Failed to fill out require information.'
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.find(params[:review_id])
    if !Review.valid_rating?(review_params[:rating])
        flash[:rating] = 'Please enter a rating between 1 and 5'
        redirect_to "/shelters/#{params[:shelter_id]}/reviews/#{review.id}/edit"
        return
    end
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
