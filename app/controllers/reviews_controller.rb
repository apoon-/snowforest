class ReviewsController < ApplicationController
  before_filter :load_product
  before_filter :ensure_logged_in, :only => [:edit, :create, :update, :destroy]


  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user_id = current_user.id
  
    # @review =  Review.new(
    #   :comment => params[:review][:comment],
    #   :product_id => @product.id,
    #   :user_id => current_user.id
    # )
#depreciated HTML non-AJAX code
    # if @review.save
    #   redirect_to products_path, notice: "Review created successfully"
    # else
    #   render :action => :show
    # end

    respond_to do |format|
      if @review.save
        format.html { redirect_to product_path(@product.id), notice: "Review created successfully."} #same as before
        format.js {} #create.js.erb
      else
        format.html { render 'products/show', alert: "Error in posting review." } #same as before
        format.js {} # create.js.erb
      end
    end

  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private 

  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end
end
