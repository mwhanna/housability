class AddUserEmailToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :user, :string
  end
end
