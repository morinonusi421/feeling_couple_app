class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :sex
      t.boolean :choosed
      t.references :loving, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
