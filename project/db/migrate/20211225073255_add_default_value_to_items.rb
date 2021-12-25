class AddDefaultValueToItems < ActiveRecord::Migration[6.1]
  def change
    change_column_default :items, :sale, 0
  end
end
