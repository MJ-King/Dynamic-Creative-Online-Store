class ProductsController < ApplicationController

  def index
    @products = Product.all
  end
  
  def new
    @product = Product.new
  end
  
  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to product_path(@product)
  end
  
  def show
    @product = Product.find(params[:id])
    cat_id = @product.category_id
    @category = Category.find_by id: cat_id
  end

  private
  def product_params
    params.require(:product).permit(:name, :price, :category_id, :product_id)
  end
end

  