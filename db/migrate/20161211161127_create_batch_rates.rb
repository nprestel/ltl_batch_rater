class CreateBatchRates < ActiveRecord::Migration[5.0]
  def change
    create_table :batch_rates do |t|
      t.string :shipmentID
      t.string :carrier_scac,  default: "CTII"
      t.float :nmfc_class,  default: 70
      t.string :orig_5zip
      t.string :orig_state
      t.string :orig_country,  default: "USA"
      t.string :dest_5zip
      t.string :dest_state
      t.string :dest_country,  default: "USA"
      t.integer :weight
      t.decimal :disc_charge, precision: 9, scale: 2
      t.decimal :discount, precision: 4, scale: 3
      t.decimal :charge, precision: 9, scale: 2
      t.decimal :min, precision: 5, scale: 2
      t.string :error_code,  default: "NONE"

      t.timestamps
    end
  end
end
