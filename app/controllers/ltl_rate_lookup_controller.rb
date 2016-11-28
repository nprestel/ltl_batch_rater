class LtlRateLookupController < ApplicationController
		def index
		params[:fak] = "70"
		#@ltl_rate = Rate.new(params[:origin_zip], params[:dest_zip], params[:fak], params[:weight]) if params[:origin_zip].present? && params[:dest_zip].present? && params[:fak].present? && params[:weight].present?
    	@zip_code1 = ZipCode.new(params[:origin_zip]) if params[:origin_zip].present?
    	@zip_code2 = ZipCode.new(params[:dest_zip]) if params[:dest_zip].present?
    	@ltl_discount = LtlDiscount.find_by(origin_state: ZipCode.new(params[:origin_zip]).state, dest_state: ZipCode.new(params[:dest_zip]).state)
    	@transit = Transit.find_by(origin_state: ZipCode.new(params[:origin_zip]).state, dest_state: ZipCode.new(params[:dest_zip]).state)

  	end
end
