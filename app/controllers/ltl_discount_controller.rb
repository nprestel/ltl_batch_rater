class LtlDiscountController < ApplicationController

	def index
	    @ltl_discounts = LtlDiscount.order(:carrier_scac, :origin_state, :dest_state, :dest_zip)

	    respond_to do |format|
	      format.html
	      format.csv { send_data @ltl_discounts.to_csv }
	    end
  	end
  	
end
