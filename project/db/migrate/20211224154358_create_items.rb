class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :cost
      t.integer :stock
      t.integer :sale
      t.string :properties

      t.timestamps
    end
  end
end
