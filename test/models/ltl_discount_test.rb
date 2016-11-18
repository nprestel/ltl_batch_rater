# == Schema Information
#
# Table name: ltl_discounts
#
#  id           :integer          not null, primary key
#  carrier_scac :string
#  origin_state :string
#  dest_state   :string
#  discount     :decimal(5, 2)
#  min          :decimal(5, 2)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  group        :string
#

require 'test_helper'

class LtlDiscountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
