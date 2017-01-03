class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :score

      t.timestamps null: false
    end
  end
end
