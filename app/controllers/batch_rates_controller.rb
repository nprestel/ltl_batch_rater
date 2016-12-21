class BatchRatesController < ApplicationController
	
	def index
	    @batch_rates = BatchRate.order(:disc_charge)

	    respond_to do |format|
	      format.html
	      format.csv { send_data @batch_rates.to_csv }
	    end
  	end

	def import
		accepted_formats = [".csv"]
		if params[:file].present?
			if accepted_formats.include? File.extname(params[:file].path)
				
				if CSV.read(params[:file].path).size <= 10001
					BatchRate.delete_all

					HardWorker.perform_async(params[:file].path)

					#BatchRate.import_rates(params[:file])  
				  	flash[:success] = "Data Successfully Imported, Results Available!"
				  
				  redirect_to batch_rates_path
				else
					flash[:error] = "FILE TOO LARGE! MUST BE < 10,000 ROWS."
					redirect_to batch_rates_path
				end

			else
				flash[:error] = "INVALID FILE TYPE! Should be CSV."
				redirect_to batch_rates_path
			end
		  
		else
			flash[:error] = "No File Chosen"
			redirect_to batch_rates_path
		end

	end
end
