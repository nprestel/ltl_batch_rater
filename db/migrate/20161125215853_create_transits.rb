class CreateTransits < ActiveRecord::Migration[5.0]
  def change
    create_table :transits do |t|
      t.text :origin_state
      t.text :dest_state
      t.integer :days

      t.timestamps
    end
  end
end
