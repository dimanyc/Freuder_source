class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :owner, polymorphic: true
	belongs_to :processor, polymorphic: true
	has_many :filters

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false, uniqueness: true

	serialize :slipped, Array


	# Model Methods

	def self.refresh_tweets
		tweets = $client.home_timeline

		if tweets
			tweets.each do |tweet|
				Message.create( body:tweet.text, author:tweet.user.screen_name, author_image_url: tweet.user.profile_image_uri.to_s)
			end# @tweets.each do |tweet|
		end	# if tweets
	end
	
	def append_to_slipped(slip)
		unless self.slipped.include?(slip)
			self.slipped << slip
			self.save
		end
	end


	### Do I need this? 
	def self.increase_slipped_count
		self.slipped_count =+ 1
		self.save
	end


end
