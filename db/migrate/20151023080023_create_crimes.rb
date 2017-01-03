class CreateCrimes < ActiveRecord::Migration
  def change
    create_table :crimes do |t|
      t.string :description
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps null: false
    end
  end
end