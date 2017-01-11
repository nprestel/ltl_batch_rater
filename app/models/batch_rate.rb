# == Schema Information
#
# Table name: batch_rates
#
#  id           :integer          not null, primary key
#  shipmentID   :string
#  carrier_scac :string           default("CTII")
#  nmfc_class   :float            default(70.0)
#  orig_5zip    :string
#  orig_state   :string
#  orig_country :string           default("USA")
#  dest_5zip    :string
#  dest_state   :string
#  dest_country :string           default("USA")
#  weight       :integer
#  disc_charge  :decimal(9, 2)
#  discount     :decimal(4, 3)
#  charge       :decimal(9, 2)
#  min          :decimal(5, 2)
#  error_code   :string           default("NONE")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class BatchRate < ApplicationRecord

	attr_accessor :flash_notice

	def self.import_rates(file)

		# READ IMPORTED CSV FILE, SKIP HEADER ROW, CREATE ARRAY AND IMPORT INTO BATCH_RATE TABLE
		# FILE VALIDATION (IS CSV & EXISTS) ALONG WITH TABLE DROP OCCURS IN THE BATCHRATE CONTROLLER

		batch_rates = CSV.read(file)
		batch_rates.shift

		@completion_flag = FALSE


		CSV.foreach(file, headers: true) do |row|
			orig_zip_call = ZipCode.get_zip(row['orig_5zip']) # set variable to orig_zip method result to limit calls
			dest_zip_call = ZipCode.get_zip(row['dest_5zip']) # set variable to dest_zip method result to limit calls


			if !(/\A[-+]?\d+\z/ === row['weight']) #check if weight is number, if 'no' return error message
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "MISSING OR INVALID WEIGHT")
			elsif (row['weight'].to_i.between?(1,15000) == false) #check if weight is between 1 & 15k, if 'no' return error message
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "WEIGHT MUST BE 1-15,000 LBS")
			elsif (row['orig_5zip'].blank? || row['dest_5zip'].blank?) #check if either zips are blank, if 'yes' return error message
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "MISSING ZIP CODE")
			elsif !(/\A\d{5}\z/ === row['orig_5zip']) || !(/\A\d{5}\z/ === row['dest_5zip']) #check if either zips are non-5 digit numeric strings, if 'yes' return error message
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "ZIP MUST BE 5 DIGITS")
			elsif (orig_zip_call == "NO MATCH" || dest_zip_call == "NO MATCH") #check if either zips are invalid, if 'yes' return error message
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "INVALID ZIP CODE")
			else 
					rate_call = Rate.get_rate('CTII', row['orig_5zip'], row['dest_5zip'], '70', row['weight']) # set variable to get_rate method result to limit calls
					ltl_discount_call = LtlDiscount.get_discount(orig_zip_call.state, dest_zip_call.state)

					if rate_call == "NO MATCH" #check if rate doesn't exist, if 'yes' return error message
						BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "LANE NOT IN TARIFF")
					elsif ltl_discount_call == "NO MATCH" #check if discount doesn't exist, if 'yes' return non-discount rate with message
						BatchRate.create(:shipmentID => row['shipmentID'], :orig_5zip => row['orig_5zip'], :orig_state => orig_zip_call.state, :dest_5zip => row['dest_5zip'], :dest_state => dest_zip_call.state, :weight => row['weight'].to_i, :charge => rate_call, :error_code => "NO DISCOUNT EXISTS FOR LANE")
					else BatchRate.create(:shipmentID => row['shipmentID'], :orig_5zip => row['orig_5zip'], :orig_state => orig_zip_call.state, :dest_5zip => row['dest_5zip'], :dest_state => dest_zip_call.state, :weight => row['weight'].to_i, :discount => ltl_discount_call.first.discount.to_f, :charge => rate_call, :min => ltl_discount_call.first.min.to_f)
					end
			end
		end

		BatchRate.where(:error_code => "NONE").update_all("disc_charge = (CAST(charge as float) * (1 - CAST(discount as float)))")
		BatchRate.where("error_code = 'NO DISCOUNT EXISTS FOR LANE' AND charge < min").update_all("charge = min")
		BatchRate.where("error_code = 'NONE' AND disc_charge < min").update_all("disc_charge = min")

	end


	def self.to_csv(options = {})  # EXPORTS RECORDS TO CSV
	    desired_columns = ["shipmentID", "carrier_scac", "nmfc_class", "orig_5zip", "orig_state", "orig_country", "dest_5zip", "dest_state", "dest_country", "weight", "disc_charge", "discount", "charge", "min", "error_code"]
	    CSV.generate(options) do |csv|
	      csv << desired_columns
	      all.each do |batch_rates|
	        csv << batch_rates.attributes.values_at(*desired_columns)
	      end
	    end
  	end

	private

end
