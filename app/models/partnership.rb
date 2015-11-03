class Partnership < ActiveRecord::Base
  validates :lead_id, uniqueness: {scope: :follow_id}
  validate :lead_follow_not_equal
  
  belongs_to :lead, class_name: 'User'
  belongs_to :follow, class_name: 'User'
  
  
  
  def lead_follow_not_equal
    if lead_id == follow_id
      errors.add(:lead_id, 'must be different from follow')
      errors.add(:follow_id, 'must be different from lead')
    end
  end
end
