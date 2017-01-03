class AddOccurrencesToCrimes < ActiveRecord::Migration
  def change
    add_column :crimes, :occurrences, :integer
  end
end
