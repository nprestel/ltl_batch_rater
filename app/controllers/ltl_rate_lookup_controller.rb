class LtlRateLookupController < ApplicationController
		def index
		params[:fak] = "70"
		#params[:carrier_scac] = "CTII"
		@ltl_rate = Rate.get_rate(params[:carrier_scac], params[:origin_zip], params[:dest_zip], params[:fak], params[:weight]) if params[:origin_zip].present? && params[:dest_zip].present? && params[:fak].present? && params[:weight].present?

    	@zip_code1 = ZipCode.get_zip(params[:origin_zip]) if params[:origin_zip].present?
    	@zip_code2 = ZipCode.get_zip(params[:dest_zip]) if params[:dest_zip].present?

    	@ltl_discount = LtlDiscount.get_discount(@zip_code1.state, @zip_code2.state) if params[:origin_zip].present? && params[:dest_zip].present? && @zip_code1 != "NO MATCH" && @zip_code2 != "NO MATCH"
    	#@transit = Transit.find_by(origin_state: ZipCode.new(params[:origin_zip]).state, dest_state: ZipCode.new(params[:dest_zip]).state)
  		end
end
