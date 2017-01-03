class AddFavoriteToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :favorite, :boolean
  end
end
