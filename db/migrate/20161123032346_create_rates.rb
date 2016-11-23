class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.string :carrier_scac
      t.float :nmfc_class
      t.string :orig_3zip
      t.string :dest_3zip
      t.string :weight_break
      t.float :cwt

      t.timestamps
    end
  end
end
