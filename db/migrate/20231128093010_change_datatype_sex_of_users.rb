class ChangeDatatypeSexOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :sex, :integer
  end
end
