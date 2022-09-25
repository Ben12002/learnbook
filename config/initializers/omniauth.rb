Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['client_id'], ENV['client_secret'], {:client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
end