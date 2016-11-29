class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :rates, :weight_break, :weight_group_name
  end
end
