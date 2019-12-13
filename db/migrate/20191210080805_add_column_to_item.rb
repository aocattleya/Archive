class AddColumnToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :description, :text, null: false
    add_column :items, :category_id, :integer, null: false
  end
end
