# == Schema Information
#
# Table name: zip_codes
#
#  id         :integer          not null, primary key
#  zip        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city       :string
#  state      :string
#

class ZipCode < ApplicationRecord

	def self.get_zip(zip)
	
		@search = self.find_by('zip = ? ', zip.to_s)
		
		if @search.blank?
  			@search = 'NO MATCH'
  		else
  			@search
		end
		 
	end

end
