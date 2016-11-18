class AddGroupToLtlDiscounts < ActiveRecord::Migration[5.0]
  def change
    add_column :ltl_discounts, :group, :string
  end
end
