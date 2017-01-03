class CreateCommunityCentres < ActiveRecord::Migration
  def change
    create_table :community_centres do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :address
      t.string :website

      t.timestamps null: false
    end
  end
end
