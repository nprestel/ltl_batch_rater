class CreateLtlWeightGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :ltl_weight_groups do |t|
      t.integer :min_weight
      t.weight :max
      t.integer :rate_block_number
      t.text :weight_group_name

      t.timestamps
    end
  end
end
