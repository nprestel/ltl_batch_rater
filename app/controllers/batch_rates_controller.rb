class BatchRatesController < ApplicationController
	before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]

	
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
				
				if CSV.read(params[:file].path).size <= 5001
					BatchRate.delete_all

					uploader = BatchrateUploader.new
					handle = open(params[:file].path)
					handle.binmode
					if handle.is_a?(StringIO)
					  tempfile = Tempfile.new("my-uploader-open-uri")
					  tempfile.write(handle.read)
					  tempfile.close
					  handle = tempfile
					end
					uploader.store!(handle)
					
					# ORIGINAL CODE
					#---------------
					#uploader = BatchrateUploader.new
 					#File.open(params[:file].path) do |file|
					#  something = uploader.store!(file)
					#end
					#---------------


					#HardWorker.perform_async(params[:file].path)
					#BatchRateMonitorJob.perform_later params[:file].path

					BatchRateMonitorJob.perform_later(uploader.url, params[:email_entry])

					#BatchRate.import_rates(params[:file])  
				  	flash[:success] = "Data Successfully Imported and Being Processed."
				  
				  redirect_to batch_rates_path
				else
					flash[:error] = "FILE TOO LARGE! MUST BE < 5,000 ROWS."
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

private
  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end

end