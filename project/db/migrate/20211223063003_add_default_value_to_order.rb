class AddDefaultValueToOrder < ActiveRecord::Migration[6.1]
  def change
    change_column_default :orders, :status, 0
  end
end
