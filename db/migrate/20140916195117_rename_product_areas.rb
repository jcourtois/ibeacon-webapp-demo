class RenameProductAreas < ActiveRecord::Migration
  class ProductArea < ActiveRecord::Base
  end

  def up
    ProductArea.update_all("name = 'Dairy'", "name = 'Yogurt'")
    ProductArea.update_all("name = 'Soup'", "name = 'Condiments and sauces'")
    ProductArea.update_all("name = 'Pet Food'", "name = 'Pet food and pet products'")
    ProductArea.update_all("name = 'Salad Dressing'", "name = 'Salad dressings and mayonnaise'")
    ProductArea.update_all("name = 'Crackers'", "name = 'Crackers, cookies and bread'")
  end

  def down
    ProductArea.update_all("name = 'Yogurt'", "name = 'Dairy'")
    ProductArea.update_all("name = 'Condiments and sauces'", "name = 'Soup'")
    ProductArea.update_all("name = 'Pet food and pet products'", "name = 'Pet Food'")
    ProductArea.update_all("name = 'Salad dressings and mayonnaise'", "name = 'Salad Dressing'")
    ProductArea.update_all("name = 'Crackers, cookies and bread'", "name = 'Crackers'")
  end
end
