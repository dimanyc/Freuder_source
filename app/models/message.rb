class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true
	has_many :filters

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true


	# Model Methods

	def self.refresh_tweets
		tweets = $client.home_timeline
		#tweets =

		if tweets
			tweets.each do |tweet|
				Message.create( body: tweet.text, author:$client.status(tweet).user.screen_name, author_image_url: $client.status(tweet).user.profile_image_url_https)
			end
		end	# @tweets.each do |tweet|
	end
end
