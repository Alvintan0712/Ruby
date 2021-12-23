class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :product
      t.references :user
      t.decimal :price

      t.timestamps
    end
  end
end
