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
    
    client = Savon.client(wsdl: 'http://www.webservicex.net/uszip.asmx?WSDL')

    response = client.call(:get_info_by_zip, message: {"USZip"=> zip })
    if response.success?
      data = response.to_array(:get_info_by_zip_response, :get_info_by_zip_result, :new_data_set, :table).first
      if data
        if (data[:city] != nil && data[:city] != 0) 
          @state = data[:state]
          @city = data[:city]
        else
          @state = data[:error_message]
        end
      end
    end
  
  end
end
