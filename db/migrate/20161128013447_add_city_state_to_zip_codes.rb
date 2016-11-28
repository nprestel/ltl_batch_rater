class AddCityStateToZipCodes < ActiveRecord::Migration[5.0]
  def change
    add_column :zip_codes, :city, :string
    add_column :zip_codes, :state, :string
  end
end
