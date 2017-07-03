class Category < ActiveRecord::Base
  require 'csv'
  has_many :products
  validates :category, presence: true
  
  def self.import(file)
    @product_IDs = Product.pluck('product_id')
    @categories = Category.pluck('category')
    CSV.foreach(file.path, headers:true) do |row|
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