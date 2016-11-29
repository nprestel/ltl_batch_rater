# == Schema Information
#
# Table name: rates
#
#  id                :integer          not null, primary key
#  carrier_scac      :string
#  nmfc_class        :float
#  orig_3zip         :string
#  dest_3zip         :string
#  weight_group_name :string
#  cwt               :float
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class RateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
