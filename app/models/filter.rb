class Filter < ActiveRecord::Base
	
	# Active Relations:
	belongs_to :user 
	has_many :slips
	has_many :filtered_messages 

	# Data Validation:
	validates_presence_of :name


	# Model-Level Methods:
	def analyze_message(message,slip)
		if message.include?slip 
			Slip.filtered_messages << message 
		end
	end
end
