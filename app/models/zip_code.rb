# == Schema Information
#
# Table name: zip_codes
#
#  id         :integer          not null, primary key
#  zip        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ZipCode < ApplicationRecord
	attr_reader :state, :city

  def initialize(zip)
    
    client = Savon.client(wsdl: 'http://ws.cdyne.com/psaddress/addresslookup.asmx?wsdl')

    response = client.call(:return_city_state, message: {"zipcode"=> zip, "LicenseKey" => "?" })
    if response.success?
      data = response.to_array(:return_city_state_response, :return_city_state_result).first
      if data
        if (data[:city] != nil && data[:city] != 0) 
          @state = data[:state_abbrev]
          @city = data[:city]
        else
          @state = data[:error_message]
        end
      end
    end
  
  end
end
