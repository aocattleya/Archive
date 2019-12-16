class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string  :name,            null: false, index: true
      t.integer :price,           null: false, index: true
      t.integer :size,            index: true
      t.integer :condition,       null: false
      t.integer :shipping_date,   null: false
      t.integer :shipping_price,  null: false
      t.integer :shipping_area,   null: false
      t.integer :shipping_method, null: false
      t.references :user,         index: true, foreign_key: true
      t.timestamps
    end
  end
end
