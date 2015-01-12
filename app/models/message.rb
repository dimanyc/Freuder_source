class Message < ActiveRecord::Base
	# Active Relations: 
	belongs_to :messageable, polymorphic: true 
	#has_many :filters

	# Validations:
	validates :body, length: {minimum: 3, maximum: 140}, allow_blank: false


	# Model Methods

end
