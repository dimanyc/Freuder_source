class Filter < ActiveRecord::Base
	
	# Active Relations:
	belongs_to :user 
	has_many :messages, as: :messageable
	#has_many :filtered_messages 

	# Data Validation:
	validates_presence_of :name, :slips


	# Model-Level Methods:

	def evaluate_message(message)
		@message_slipped = message.slipped
		@message_body = message.body.downcase.gsub(/[^a-z0-9\s]/i, '')
		@slips = self.slips.downcase.split(", ")

		
		# Method works on the first slip
		@slips.each do |slip|
			if @slips.count > 1

				if 	@slips.all? { |slip| @message_body.include?(slip) }
					@message_slipped << @slips.to_s.gsub(/[^a-z0-9\s]/i, '')
					return true
				else
					return false
				end# if @slips.all?				

			else

				if 	@slips.any? { |slip| @message_body.include?(slip) }
					@message_slipped << slip
					return true
				else
					return false
				end# if @slips.any?
			end# if @slips.count > 1
		end #@slips.each do 


		# return true && message.slipped << slip if @slips.any? { |slip| @message_body.include?(slip) }

		# false 

	end
end
