class Category < ActiveRecord::Base
  require 'csv'
  
  #1 category has many products
  has_many :products
  
  #category must be created with the category field entered.
  validates :category, presence: true
  
  #method to idempotently import products and categorys from CSV
  def self.import
    CSV.foreach(Rails.root.join('tmp', 'products.csv')) do |row|
      @product_IDs = Product.pluck('product_id')
      @categories = Category.pluck('category')
      if @categories.exclude? row[1]
        category = Category.create category: row[1]
      end
      if @product_IDs.exclude? row[0]
        category = Category.find_by category: row[1]
        product = Product.create name: row[2], price: row[3], category_id: category.id, product_id: row[0]
      end
    end
  end
end