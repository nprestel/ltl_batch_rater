# == Schema Information
#
# Table name: ltl_discounts
#
#  id           :integer          not null, primary key
#  carrier_scac :string
#  origin_state :string
#  dest_state   :string
#  discount     :decimal(4, 3)
#  min          :decimal(5, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  group        :string
#  dest_zip     :string
#

require 'csv'

class LtlDiscount < ApplicationRecord

	def self.get_discount(carrier_scac, origin_state, dest_state, dest_zip)
		if carrier_scac = "pnii"
			@search = self.where('carrier_scac = ? AND origin_state = ? AND dest_zip = ?', carrier_scac.upcase, origin_state, dest_zip)
		else
			@search = self.where('carrier_scac = ? AND origin_state = ? AND dest_state = ?', carrier_scac.upcase, origin_state, dest_state)
		end

		if @search.blank?
  			@search = 'NO MATCH'
  		else
  			@search
		end
		 
	end

	def self.to_csv(options = {})
		desired_columns = ["carrier_scac", "origin_state", "dest_state", "dest_zip", "discount", "min"]
	  CSV.generate(options) do |csv|
	    csv << desired_columns
	    all.each do |ltl_discount|
	      csv << ltl_discount.attributes.values_at(*desired_columns)
	    end
	  end
	end

end
