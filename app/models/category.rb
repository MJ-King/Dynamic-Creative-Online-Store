class Category < ActiveRecord::Base
  require 'csv'
  
  #1 category has many products
  has_many :products
  
  #category must be created with the category field entered.
  validates :category, presence: true
  
  #method to idempotently import products and categories from CSV stored in tmp folder
  def self.import
    CSV.foreach(Rails.root.join('tmp', 'products.csv'), headers: true) do |row|
      @product_IDs = Product.pluck('product_id')
      @categories = Category.pluck('category')
      
      #check if category exists, creates new category if not.
      if @categories.exclude? row[1]
        Category.create category: row[1]
      end
      
      #check if product exists, creates new product if not.
      if @product_IDs.exclude? row[0]
        category = Category.find_by category: row[1]
        Product.create name: row[2], price: row[3], category_id: category.id, product_id: row[0]
      end
    end
  end
end