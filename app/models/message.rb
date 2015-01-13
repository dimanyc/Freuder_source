class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true 

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true


	# Model Methods

	def create_message_from_tweet(tweet)
		#self.body = tweet.
	end

end
