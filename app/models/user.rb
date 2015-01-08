class User < ActiveRecord::Base
	
	#Active Relations:
	
	#Model-level methods: 
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.image_url = auth.info.image
			user.save
		end
		#where(auth.slice("provider","uid")).first || create_from_omniauth(auth)

	end

	# def self.create_from_omniauth(auth)
	# 	create! do |user|
	# 		user.provider = auth["provider"]
	# 		user.uid = auth["uid"]
	# 		user.name = auth["info"]["nickname"]
	# 	end
	# end
end
