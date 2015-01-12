class Filter < ActiveRecord::Base
	
	# Active Relations:
	belongs_to :user 
	#has_many :filtered_messages 

	# Data Validation:
	validates_presence_of :name


	# Model-Level Methods:
	# def analyze(message,slip)
	# 	slips.each do |i|
	# 	if message.include?slip 
	# 		Slip.filtered_messages << message 
	# 	end
	# end
end
