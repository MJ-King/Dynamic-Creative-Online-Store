class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to Category_path(@product)
  end
  
  def show
    @category = Category.find(params[:id])
    @category_products = @category.products.paginate(page: params[:page], per_page:5)
  end

  def import
    Category.import(params[:file])
    redirect_to root_url, notice: "Data imported!"
  end
  
  private
  def category_params
    params.require(:category).permit(:category)
  end
  
end
