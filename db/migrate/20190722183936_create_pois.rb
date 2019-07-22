class CreatePois < ActiveRecord::Migration[5.2]
  def change
    create_table :pois do |t|
      t.string :name
      t.float :ne_latitude
      t.float :ne_longitude
      t.float :sw_latitude
      t.float :sw_longitude
      t.integer :population
      t.string :state
      t.string :land_area
      t.string :total_area
      t.timestamps
    end
  end
end
