class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :wishlist, null: false, foreign_key: true
      t.string :title, null: false
      t.text :link
      t.text :description
      t.integer :status, default: 0
      t.integer :reserved_by
      t.integer :gifted_by
      t.datetime :reserved_on
      t.datetime :gifted_on

      t.timestamps
    end
  end
end
