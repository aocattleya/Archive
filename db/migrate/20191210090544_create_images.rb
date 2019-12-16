class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string     :image, null:false
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
