# == Schema Information
#
# Table name: transits
#
#  id           :integer          not null, primary key
#  origin_state :text
#  dest_state   :text
#  days         :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class TransitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
