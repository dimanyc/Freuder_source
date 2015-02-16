$client = Twitter::REST::Client.new do |config|

  config.consumer_key = ENV['TWITTER_API_KEY']
  config.consumer_secret = ENV['TWITTER_API_SECRET']
  config.access_token = ENV['TWITTER_API_TOKEN']
  config.access_token_secret = ENV['TWITTER_API_SECRET']
  # config.consumer_key = 'gsrp95ZrYl09Twsu6CixoCz6G'
  # config.consumer_secret = '0ME90XGPeFK1cdrTdrRUpqhYtCG6SkdKnjH9bL8u9Vtu7pDgTy'
  # config.access_token = '59153881-wFDKfvAhAZ9Pvkmynzt2V8HkPzPukk7pLYia13vPV'
  # config.access_token_secret = 'oKrpXG98DGzrR1jxsKrXphYzRbJdIK2gKhOoCgI9AmOEq'
end