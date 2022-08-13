class CreateWishlists < ActiveRecord::Migration[7.0]
  def change
    create_table :wishlists do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title
      t.integer :publicity_level, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
