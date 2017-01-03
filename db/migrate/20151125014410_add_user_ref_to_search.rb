class AddUserRefToSearch < ActiveRecord::Migration
  def change
    add_reference :searches, :user, index: true, foreign_key: true
  end
end
