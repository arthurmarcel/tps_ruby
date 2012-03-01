class Person < ActiveRecord::Base	
	belongs_to :address
	has_many :child	
	
	validates :last_name, :presence => true
	validates :first_name, :presence => true
	validates :username, :uniqueness => true
end
