require 'test_helper'

class PartnershipTest < ActiveSupport::TestCase
  test "lead id and follow id cannot be null" do
    partnership = Partnership.new
    
    assert_not partnership.valid?
    assert_equal ["can't be blank", "lead and follow must be different"], partnership.errors[:lead_id]
    assert_equal ["can't be blank", "lead and follow must be different"], partnership.errors[:follow_id]
  end
  
  test "lead id and follow id cannot equal" do
    partnership = Partnership.new(lead_id: 2, follow_id: 2)
    
    assert_not partnership.valid?
    assert_equal ['lead and follow must be different'], partnership.errors[:lead_id]
    assert_equal ['lead and follow must be different'], partnership.errors[:follow_id]
  end
  
  test "valid lead id and follow id" do
    assert Partnership.new(lead_id: 1, follow_id: 2).valid?
  end
  
  test "able to create same partnership reversed" do
    assert Partnership.create(lead_id: 1, follow_id: 2).valid?
    assert Partnership.create(lead_id: 2, follow_id: 1).valid?
    assert_equal 2, Partnership.count
  end
  
  test "cannot create same partnership" do
    assert Partnership.create(lead_id: 1, follow_id: 2).valid?
    assert_equal 1, Partnership.count
    
    p = Partnership.new(lead_id: 1, follow_id: 2)
    assert_not p.valid?
    assert_equal ['has already been taken'], p.errors[:lead_id]
    assert_equal ['has already been taken'], p.errors[:follow_id]
    assert_not p.save
    
    assert_equal 1, Partnership.count
  end
  
  test "db unique constraint on lead and follow" do
    Partnership.create(lead_id: 1, follow_id: 2)
    assert_equal 1, Partnership.count
    
    p = Partnership.new(lead_id: 1, follow_id: 2)
    assert_raises ActiveRecord::RecordNotUnique do
      p.save(validate: false)
    end
  end
  
  test "can create two leads same follow" do 
    Partnership.create(lead_id: 1, follow_id: 2)
    Partnership.create(lead_id: 3, follow_id: 2)
    assert_equal 2, Partnership.count
  end
  
  test "can create two follows same lead" do 
    Partnership.create(lead_id: 1, follow_id: 2)
    Partnership.create(lead_id: 1, follow_id: 3)
    assert_equal 2, Partnership.count
  end
  
end
