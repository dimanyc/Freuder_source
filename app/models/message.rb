class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true 

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true


	# Model Methods
	def save_tweets_to_messages(message)

		message = Message.class

		@tweets = $client.home_timeline

		@tweets.each do |tweet|
				message.create( body:tweet.text, author:tweet.user.screen_name)
		end	# @tweets.each do |tweet|

	end # def save_tweets_to_messages
end
