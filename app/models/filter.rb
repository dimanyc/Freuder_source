class Filter < ActiveRecord::Base
	
	# Active Relations:
	belongs_to :user 
	has_many :messages, as: :processor
	#has_many :filtered_messages 

	# Data Validation:
	validates_presence_of :name, :slips

	serialize :filtered_message_ids, Array


	# Model-Level Methods:

	def evaluate_message(message)
		@slips = self.slips.downcase.split(", ")
		@message_body = message.body.downcase.gsub(/[^a-z0-9\s]/i, '')

		@new_filter_message = message
	

		if @slips.count > 1 
			if @slips.all? { |slip| @message_body.include?(slip) }
				self.messages << message
				self.user.messages << message
				self.append_to_filtered_message_ids(message.id)
				message.append_to_slipped(@slips)
				return true 
			end
		
		else

			if @slips.any? { |slip| @message_body.include?(slip) }
				self.messages << message
				self.user.messages << message
				self.append_to_filtered_message_ids(message.id)
				message.append_to_slipped(@slips)
				return true 
			end
			
		end 
	end

	# Appending `good` ids to Filter
	def append_to_filtered_message_ids(message)
		self.filtered_message_ids << message
		self.save
	end


end
