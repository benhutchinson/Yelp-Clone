class ReviewsController < ApplicationController

	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@user = current_user.id

		if @restaurant.reviews.map {|review| review.user_id }.include?(@user)
			flash[:notice] = 'Review something else'
			redirect_to restaurants_path
		else 
			@restaurant.reviews.create(review_params)
			flash[:notice] = 'U R SUCH A LEDGE'
			redirect_to restaurants_path
		end
	end

	def destroy
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = @restaurant.reviews.find(params[:id])
		if current_user && @review.user_id == current_user.id
			@review.destroy
			flash[:notice] = 'IF WE DELETE EVERYTHING, THERE WILL BE NOTHING TO READ'
		else
			flash[:notice] = 'Sorry, you are not permitted since you are not the author'
		end
		redirect_to restaurants_path
	end

	def review_params
	  params.require(:review).permit(:thoughts, :rating, :user_id)
	end

end
