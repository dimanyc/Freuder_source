class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true
	has_many :filters

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true



	# Model Methods

	def self.refresh_tweets
		tweets = $client.home_timeline

		if tweets
			tweets.each do |tweet|
				Message.create( body:tweet.text, author:tweet.user.screen_name, author_image_url: tweet.user.profile_image_uri.to_s)
			end# @tweets.each do |tweet|
		end	# if tweets
	end

	def self.post_tweet(tweet)
		Message.create( body:tweet.body, author:curren_user.username)
	end
	

end
