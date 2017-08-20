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
#  ctii_cwt          :float
#  pnii_cwt          :float
#

class Rate < ApplicationRecord
	def self.get_rate(carrier_scac, origin_zip, dest_zip, fak, weight)

		weight_group_name = LtlWeightGroup.get_weight_group(weight)
		weight_group_bump_name = LtlWeightGroup.get_weight_group_bump(weight)
		weight_bump = LtlWeightGroup.get_weight_group_bump_floor(weight_group_bump_name)

		origin_3zip = origin_zip[0,3]
		dest_3zip = dest_zip[0,3]

		scac = carrier_scac.to_s + "_cwt"
		
		@search = self.where('orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', origin_3zip, dest_3zip, weight_group_name)
		# @search = self.where('nmfc_class = ? AND orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', fak, origin_3zip, dest_3zip, weight_group_name)
		# removed version with FAK lookup

		@search2 = self.where('orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', origin_3zip, dest_3zip, weight_group_bump_name)

		# @search2 = self.where('nmfc_class = ? AND orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', fak, origin_3zip, dest_3zip, weight_group_bump_name)
		# removed version with FAK lookup

		
		if @search.blank?
  			@search = 'NO MATCH'
  		elsif (weight_group_bump_name == 'M20M')
  			@search = (@search.first.read_attribute(scac)/100) * (weight.to_f/100)
  		elsif ((@search.first.read_attribute(scac)/100) * (weight.to_f/100)) > ((@search2.first.read_attribute(scac)/100) * (weight_bump.to_f/100))
  			@search = (@search2.first.read_attribute(scac)/100) * (weight_bump.to_f/100)
  		else
  			@search = (@search.first.read_attribute(scac)/100) * (weight.to_f/100)
		end
		 
	end

end
