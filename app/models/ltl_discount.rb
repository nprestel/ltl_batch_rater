# == Schema Information
#
# Table name: ltl_discounts
#
#  id           :integer          not null, primary key
#  carrier_scac :string
#  origin_state :string
#  dest_state   :string
#  discount     :decimal(5, 2)
#  min          :decimal(5, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'csv'

class LtlDiscount < ApplicationRecord

	def self.to_csv(options = {})
		desired_columns = ["carrier_scac", "origin_state", "dest_state", "discount", "min"]
	  CSV.generate(options) do |csv|
	    csv << desired_columns
	    all.each do |ltl_discount|
	      csv << ltl_discount.attributes.values_at(*desired_columns)
	    end
	  end
	end

end
