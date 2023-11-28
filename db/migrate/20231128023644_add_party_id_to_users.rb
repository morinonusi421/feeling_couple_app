class AddPartyIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :party_id, :integer
  end
end
