class Partnership < ActiveRecord::Base
  validates :lead_id, :follow_id, presence: true
  validates :lead_id, uniqueness: {scope: :follow_id}
  validates :follow_id, uniqueness: {scope: :lead_id}
  validate :lead_follow_not_equal
  
  belongs_to :lead, class_name: 'User'
  belongs_to :follow, class_name: 'User'
    
  def lead_follow_not_equal
    if lead_id == follow_id
      errors.add(:lead_id, 'lead and follow must be different')
      errors.add(:follow_id, 'lead and follow must be different')
    end
  end
  
end
