class ChangeDiscountFieldInLtlDiscount < ActiveRecord::Migration[5.0]
  def change
  	change_column :ltl_discounts, :discount, :decimal, precision: 4, scale: 3
  end
end
