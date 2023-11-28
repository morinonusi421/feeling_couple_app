class RemoveLoveFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :love, :string
  end
end
