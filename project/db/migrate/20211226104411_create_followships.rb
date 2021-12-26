class CreateFollowships < ActiveRecord::Migration[6.1]
  def change
    create_table :followships do |t|
      t.references :shop, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
