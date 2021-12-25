class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :product
      t.text :address
      t.string :phone
      t.decimal :price
      t.integer :status
      t.string :delivery

      t.timestamps
    end
  end
end
