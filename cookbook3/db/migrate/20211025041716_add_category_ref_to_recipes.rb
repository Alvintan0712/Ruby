class AddCategoryRefToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_reference :recipes, :category, foreign_key: true
  end
end
