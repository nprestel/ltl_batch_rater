class LtlRateLookupController < ApplicationController
		def index
		params[:fak] = "70"
    	@zip_code1 = ZipCode.new(params[:origin_zip]) if params[:origin_zip].present?
    	@zip_code2 = ZipCode.new(params[:dest_zip]) if params[:dest_zip].present?
  	end
end
