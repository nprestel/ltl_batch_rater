# == Schema Information
#
# Table name: batch_rates
#
#  id           :integer          not null, primary key
#  shipmentID   :string
#  carrier_scac :string
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

require 'test_helper'

class BatchRateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
