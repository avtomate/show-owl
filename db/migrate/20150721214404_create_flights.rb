class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.string :route
      t.integer :length

      t.timestamps null: false
    end
  end
end
