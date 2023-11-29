class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sex
      t.boolean :voted

      t.timestamps
    end
  end
end
