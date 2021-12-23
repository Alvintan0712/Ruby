class AddDeliveryToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery, :string
  end
end
