class CreateTransacts < ActiveRecord::Migration[5.0]
  def change
    create_table :transacts do |t|
      t.boolean :sold, default: false
      t.text :confirmation
      t.string :evaluat
      t.references :item, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
