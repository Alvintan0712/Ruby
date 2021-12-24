class AddShopRefToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :shop, null: false, foreign_key: true
  end
end
