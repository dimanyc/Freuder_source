class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true 

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true


	# Model Methods

	def self.refresh_tweets
		tweets = $client.home_timeline

		if tweets
			tweets.each do |tweet|
				Message.create( body:tweet.text, author:tweet.user.screen_name)
			end
		end	# @tweets.each do |tweet|
	end
end
