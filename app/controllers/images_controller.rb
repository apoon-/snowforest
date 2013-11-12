class ImagesController < ApplicationController
  before_filter :load_product

  def index

  end

  def new
    @image = Image.new
  end

  def create
    # @image = Image.new(
    #     :path => params[:image][:assets_attributes]["0"][:path],
    #     :product_id => @product_id
    #   )

    @image = @product.images.build(image_params)

    if @image.save
      redirect_to products_url, :notice => "Image Uploaded"
    else
      render "new"
    end
  end

  def show
    @image = Image.find(params[:image_id])
  end

  def destroy
    @image = Image.find(params[:image_id])
    @image.destroy
    redirect_to products_path, notice: "Image Deleted"
  end

  private 

  def image_params
    params.require(:image).permit(:product_id, :path)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
