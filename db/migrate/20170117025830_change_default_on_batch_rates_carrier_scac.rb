class ChangeDefaultOnBatchRatesCarrierScac < ActiveRecord::Migration[5.0]
  def change
  	change_column_default(:batch_rates, :carrier_scac, nil)
  end
end
