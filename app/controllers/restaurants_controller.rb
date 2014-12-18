class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
  	@restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @user = current_user.id
    @restaurant = Restaurant.find(params[:id])
    if @user == @restaurant.user_id
      @restaurant.update(restaurant_params)
      flash[:notice] = 'you budding little jane austen'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'honey monster says GO AWAY!'
      redirect_to '/restaurants'
    end
  end

  def destroy
    @user = current_user.id
  	@restaurant = Restaurant.find(params[:id])
    if @user == @restaurant.user_id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
      redirect_to '/restaurants'
    else
      flash[:notice] = 'honey monster says GO AWAY!'
      redirect_to '/restaurants'
    end
  end

  def restaurant_params
  	params.require(:restaurant).permit(:name, :description, :user_id, :image)
  end

end
