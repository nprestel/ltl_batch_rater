# == Schema Information
#
# Table name: ltl_weight_groups
#
#  id                :integer          not null, primary key
#  min_weight        :integer
#  max_weight        :integer
#  rate_block_number :integer
#  weight_group_name :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class LtlWeightGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
