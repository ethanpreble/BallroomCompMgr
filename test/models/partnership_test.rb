require 'test_helper'

class PartnershipTest < ActiveSupport::TestCase
  test "follow id and lead id cannot equal" do
    partnership = Partnership.new #(lead_id: 1, follow_id: 2)
    assert_not partnership.valid?
    
  end
end
