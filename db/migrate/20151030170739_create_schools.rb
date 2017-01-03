class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.string :website

      t.timestamps null: false
    end
  end
end
