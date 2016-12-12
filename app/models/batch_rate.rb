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

	def self.import_rates(file)

		# READ IMPORTED CSV FILE, SKIP HEADER ROW, CREATE ARRAY AND IMPORT INTO BATCH_RATE TABLE
		# FILE VALIDATION (IS CSV & EXISTS) ALONG WITH TABLE DROP OCCURS IN THE BATCHRATE CONTROLLER

		batch_rates = CSV.read(file.path)
		batch_rates.shift

		CSV.foreach(file.path, headers: true) do |row|
			if !(/\A[-+]?\d+\z/ === row['weight']) #check if weight is number
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "MISSING OR INVALID WEIGHT")
			elsif (row['weight'].to_i.between?(1,15000) == false) #check if weight is between 1 & 15k
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "WEIGHT MUST BE 1-15,000 LBS")
			elsif (row['orig_5zip'].blank? || row['dest_5zip'].blank?) #check if either zips are blank
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "MISSING ZIP CODE")
			elsif (ZipCode.get_zip(row['orig_5zip']) == "NO MATCH" || ZipCode.get_zip(row['dest_5zip']) == "NO MATCH") #check if either zips are invalid
				BatchRate.create(:shipmentID => row['shipmentID'], :error_code => "INVALID ZIP CODE")
			else
				BatchRate.create(:shipmentID => row['shipmentID'], :orig_5zip => row['orig_5zip'], :orig_state => ZipCode.get_zip(row['orig_5zip']).state, :dest_5zip => row['dest_5zip'], :dest_state => ZipCode.get_zip(row['dest_5zip']).state, :weight => row['weight'].to_i)
			end
		end

	end

	def self.to_csv(options = {})  # EXPORTS RECORDS TO CSV
	    desired_columns = ["shipmentID", "carrier_scac", "nmfc_class", "orig_5zip", "orig_state", "orig_country", "dest_5zip", "dest_state", "dest_country" "weight", "disc_charge", "discount", "charge", "min", "error_code"]
	    CSV.generate(options) do |csv|
	      csv << desired_columns
	      all.each do |batch_rates|
	        csv << batch_rates.attributes.values_at(*desired_columns)
	      end
	    end
  	end

	private

end
