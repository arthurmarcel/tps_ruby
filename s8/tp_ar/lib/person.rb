class Person < ActiveRecord::Base	
	validates :last_name, :presence => true
	validates :first_name, :presence => true
	validates :username, :uniqueness => true
end
