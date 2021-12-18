class AddSaleToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :sale, :integer
  end
end
