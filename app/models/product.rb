class Product < ActiveRecord::Base
  #1 product has 1 category
  belongs_to :category
  
  #all product fields must be present to be create a product in the db
  validates :name, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  validates :product_id, presence: true
end