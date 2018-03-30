class RatingsController < ApplicationController

  def create
    # raise "Im here"

    @product = Product.find(params[:product_id])
    @rating = Rating.create(ratings_params)
    @rating.user = current_user
    @rating.product = @product
    if @rating.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
  def ratings_params
    params.require(:rating).permit(:rating, :description)
  end

end

