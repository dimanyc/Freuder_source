Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "gsrp95ZrYl09Twsu6CixoCz6G", "0ME90XGPeFK1cdrTdrRUpqhYtCG6SkdKnjH9bL8u9Vtu7pDgTy"
    {
		:secure_image_url => 'true',
		:image_size => 'original',
		:authorize_params => {
		:force_login => 'true',
		}
    }
end