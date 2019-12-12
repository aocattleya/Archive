class CreateTodohukens < ActiveRecord::Migration[5.0]
  def change
    create_table :todohukens do |t|
      t.string :todohuken_prefecture
      t.string :todohuken_city
      t.timestamps
    end
  end
end
