class AddPniiCwtToRates < ActiveRecord::Migration[5.0]
  def change
    add_column :rates, :pnii_cwt, :float
  end
end
