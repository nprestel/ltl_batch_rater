class LtlDiscountController < ApplicationController

	def index
	    @ltl_discounts = LtlDiscount.order(:origin_state, :dest_state)

	    respond_to do |format|
	      format.html
	      format.csv { send_data @ltl_discounts.to_csv }
	    end
  	end
  	
end
