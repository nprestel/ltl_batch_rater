class AddDestZipToLtlDiscounts < ActiveRecord::Migration[5.0]
  def change
    add_column :ltl_discounts, :dest_zip, :string
  end
end
