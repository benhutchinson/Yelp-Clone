class ReviewsController < ApplicationController

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@user = current_user.id 
		@review = @restaurant.reviews.create(review_params)
		redirect_to restaurants_path
		if !@review.new_record?
			flash[:notice] = 'Review something else'
		end
	end

	def review_params
	  params.require(:review).permit(:thoughts, :rating, :user_id)
	end

end
