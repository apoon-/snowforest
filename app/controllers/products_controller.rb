class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:edit, :create, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])

    if current_user
      @review = @product.reviews.build
      @image = @product.images.build
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
    # @product.images.build unless @product.images 
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to products_url
    else
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents, :images_attributes => [:path])
  end

end
