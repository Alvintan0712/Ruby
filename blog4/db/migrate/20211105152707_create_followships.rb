class CreateFollowships < ActiveRecord::Migration[5.2]
  def change
    create_table :followships do |t|
      t.references :user, foreign_key: true
      t.references :following_user, foreign_key: true
    end
  end
end
