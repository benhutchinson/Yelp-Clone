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
		before_action :authenticate_user!
		# @user = current_user.id
		@restaurant = Restaurant.find(params[:restaurant_id])
		@restaurant.reviews.destroy(review_params)
	end

	def review_params
	  params.require(:review).permit(:thoughts, :rating, :user_id)
	end

end
