class CategoriesController < ApplicationController
  
  #retrieves all stored categories from database for index view
  def index
    @categories = Category.all.order("category")
  end

  #creates new category, saves it to the db (used when importing from CSV)
  def create
    @category = Category.new(category_params)
    @category.save
  end
  
  #retrieves all products in alphabetical order from a given category for the category show view
  def show
    @category = Category.find(params[:id])
    @category_products = @category.products.paginate(page: params[:page], per_page:5).order("name")
  end

  #handles importing of CSV and displays error notice if error occurs.
  def import
    begin
      Category.import
      notice = "Import Complete"
    rescue
      notice = "There was an error whilst importing!"
    ensure
      redirect_to start_path, notice: notice
    end
  end
  
  private
    def category_params
      params.require(:category).permit(:category)
    end
end
