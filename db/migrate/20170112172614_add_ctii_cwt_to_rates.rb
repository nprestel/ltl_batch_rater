class AddCtiiCwtToRates < ActiveRecord::Migration[5.0]
  def change
    add_column :rates, :ctii_cwt, :float
  end
end
