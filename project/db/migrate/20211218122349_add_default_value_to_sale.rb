class AddDefaultValueToSale < ActiveRecord::Migration[6.1]
  def change
    change_column_default :products, :sale, 0
  end
end
