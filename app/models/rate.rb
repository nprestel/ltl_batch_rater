# == Schema Information
#
# Table name: rates
#
#  id                :integer          not null, primary key
#  carrier_scac      :string
#  nmfc_class        :float
#  orig_3zip         :string
#  dest_3zip         :string
#  weight_group_name :string
#  cwt               :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Rate < ApplicationRecord
	def self.get_rate(carrier_scac, origin_zip, dest_zip, fak, weight)
		weight_group_name = LtlWeightGroup.get_weight_group(weight)
		weight_group_bump_name = LtlWeightGroup.get_weight_group_bump(weight)
		weight_bump = LtlWeightGroup.get_weight_group_bump_floor(weight_group_bump_name)

		origin_3zip = origin_zip[0,3]
		dest_3zip = dest_zip[0,3]
		
		@search = self.where('carrier_scac = ? AND nmfc_class = ? AND orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', carrier_scac, fak, origin_3zip, dest_3zip, weight_group_name)

		@search2 = self.where('carrier_scac = ? AND nmfc_class = ? AND orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', carrier_scac, fak, origin_3zip, dest_3zip, weight_group_bump_name)

		
		if @search.blank?
  			@search = 'NO MATCH'
  		elsif (weight_group_bump_name == 'M20M')
  			@search = (@search.first.cwt/100) * (weight.to_f/100)
  		elsif ((@search.first.cwt/100) * (weight.to_f/100)) > ((@search2.first.cwt/100) * (weight_bump.to_f/100))
  			@search = (@search2.first.cwt/100) * (weight_bump.to_f/100)
  		else
  			@search = (@search.first.cwt/100) * (weight.to_f/100)
		end
		 
	end

end
