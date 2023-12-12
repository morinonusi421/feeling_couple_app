class CreateParties < ActiveRecord::Migration[7.0]
  def change
    create_table :parties do |t|
      t.string :name
      t.boolean :allow_like

      t.timestamps
    end
  end
end
