class AddIndexToPartiesName < ActiveRecord::Migration[7.0]
  def change
    add_index :parties, :name, unique: true
  end
end