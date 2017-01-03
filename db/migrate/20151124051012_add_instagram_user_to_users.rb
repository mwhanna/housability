class AddInstagramUserToUsers < ActiveRecord::Migration
  def change
    add_column :users, :instagram_user, :string
  end
end
