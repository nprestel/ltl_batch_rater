class CreateLtlDiscounts < ActiveRecord::Migration[5.0]
  def change
    create_table :ltl_discounts do |t|
      t.string :carrier_scac
      t.string :origin_state
      t.string :dest_state
      t.decimal :discount, :precision => 5, :scale => 2
      t.decimal :min, :precision => 5, :scale => 2

      t.timestamps
    end
  end
end
