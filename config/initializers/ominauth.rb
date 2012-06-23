OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'OZ9fFbXp9vH2BDHNE0kGYg', 	'ufLci04nPLEBzvRH44cF0tDJwiKwYOTqfb2WI16bI'
end