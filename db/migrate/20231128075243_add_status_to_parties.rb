class AddStatusToParties < ActiveRecord::Migration[7.0]
  def change
    add_column :parties, :status, :integer, null: false, default: 0
  end
end
