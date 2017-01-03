class CreateBorders < ActiveRecord::Migration
  def change
    create_table :borders do |t|
      t.string :name
      t.integer :score
      t.string :centre
      t.text :coords

      t.timestamps null: false
    end
  end
end