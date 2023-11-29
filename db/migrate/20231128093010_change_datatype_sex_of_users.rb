class ChangeDatatypeSexOfUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :sex, :integer USING CAST(sex AS integer)'
  end
end
