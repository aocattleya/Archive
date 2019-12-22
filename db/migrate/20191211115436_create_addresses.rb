class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :postal_code,   null: false
      t.string :prefecture,     null: false
      t.string :city,           null: false
      t.string :street,         null: false
      t.string :building
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
