class FilteredMessage < ActiveRecord::Base

	# Active Relations: 
	belongs_to :user 

	# Validations: 
	validates_uniqueness_of :body

end
