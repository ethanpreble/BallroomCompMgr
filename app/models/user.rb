class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable
         
  attr_accessor :first_name, :last_name
  
  validates :first_name, :last_name, presence: true
  
  has_many :lead_partnerships, foreign_key: :lead, class_name: 'Partnership'
  has_many :follow_partnerships, foreign_key: :follow, class_name: 'Partnership'
end
