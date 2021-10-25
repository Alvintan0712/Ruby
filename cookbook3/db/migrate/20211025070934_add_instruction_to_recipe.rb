class AddInstructionToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :instruction, :text
  end
end
