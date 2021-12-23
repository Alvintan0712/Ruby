class AddDefaultValueToRole < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :role, 1
  end
end
