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
    begin
      Category.import(params[:file])
      notice = "Successfully imported!"
    rescue
      notice = "There was an error whilst importing!"
    ensure
      redirect_to import_path, notice: notice
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:category)
    end
end
