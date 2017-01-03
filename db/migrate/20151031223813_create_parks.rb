class CreateParks < ActiveRecord::Migration
  def change
    create_table :parks do |t|
      t.string :name
      t.decimal :longitude
      t.decimal :latitude
      t.string :address
      t.string :website

      t.timestamps null: false
    end
  end
end
