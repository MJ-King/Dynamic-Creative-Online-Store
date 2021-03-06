class ProductsController < ApplicationController
  
  #creates new product and saves it for use when importing from CSV
  def create
    @product = Product.new(product_params)
    @product.save
  end
  
  #retrieves product for products#show view
  def show
    @product = Product.find(params[:id])

    #retreives category for user to return to category page
    @category = Category.find_by id: @product.category_id
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id, :product_id)
  end
end

  