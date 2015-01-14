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
				Message.create( body: tweet.text, author:$client.status(tweet).user.screen_name, author_image_url: $client.status(tweet).user.profile_image_url_https, mentions: extract_mentioned_screen_names(tweet.body),replies: extract_reply_screen_name(tweet.body))
			end
		end	# @tweets.each do |tweet|
	end


#see if it can be encapsulated 
	def self.extract_data_from_tweets
		tweets = Message.all

		tweets.each do |tweet|
			tweet.update_attributes(mentions: extract_mentioned_screen_names(tweet.body), replies: extract_reply_screen_name(tweet.body))

		end

	end


end
