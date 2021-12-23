class AddPhoneToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :phone, :string
  end
end
