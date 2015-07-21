class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :info
      t.integer :length
      t.string :genre
      t.integer :year
      t.string :country
      t.string :url

      t.timestamps null: false
    end
  end
end
