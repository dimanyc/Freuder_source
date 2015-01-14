class Filter < ActiveRecord::Base
	
	# Active Relations:
	belongs_to :user 
	has_many :messages, as: :messageable
	#has_many :filtered_messages 

	# Data Validation:
	validates_presence_of :name


	# Model-Level Methods:

	def evaluate_message(message)
		@message_body = message.body.downcase.gsub(/[^a-z0-9\s]/i, '')
		@slips = self.slips.downcase.split(", ")

		
		return true if @slips.any? { |slip| @message_body.include?(slip) }

		false 

	end
end
