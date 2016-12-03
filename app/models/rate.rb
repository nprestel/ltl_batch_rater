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
		origin_3zip = origin_zip[0,3]
		dest_3zip = dest_zip[0,3]
		
		@search = self.where('carrier_scac = ? AND nmfc_class = ? AND orig_3zip = ? AND dest_3zip = ? AND weight_group_name = ?', carrier_scac, fak, origin_3zip, dest_3zip, weight_group_name)
		
		if @search.blank?
  			@search = 'NO MATCH'
  		else
  			@search = @search.first.cwt/100 * weight/100
		end
		 
	end

end
