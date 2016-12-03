# == Schema Information
#
# Table name: ltl_weight_groups
#
#  id                :integer          not null, primary key
#  min_weight        :integer
#  max_weight        :integer
#  rate_block_number :integer
#  weight_group_name :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class LtlWeightGroup < ApplicationRecord
	def self.get_weight_group(wt)
		 self.where('min_weight <= ? AND max_weight >= ?', wt, wt).first.weight_group_name
	end

	def self.get_weight_group_bump(wt)
		if (self.where('min_weight <= ? AND max_weight >= ?', wt, wt).first.rate_block_number + 1) > 9
			self.where('min_weight <= ? AND max_weight >= ?', wt, wt).first.weight_group_name
		else
		 self.where('rate_block_number = ?', self.where('min_weight <= ? AND max_weight >= ?', wt, wt).first.rate_block_number + 1).first.weight_group_name
		end
	end
end
