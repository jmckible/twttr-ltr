if File.exist?("#{Rails.root}/config/app.yml")
  config = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env].symbolize_keys

  ENV['HOST'] = config[:host]

  ENV['SECRET_KEY_BASE'] = config[:secret_key_base]

  config[:smtp].each do |key, value|
    ENV["SMTP_#{key.upcase}"] = value.to_s
  end
  ENV['SMTP_SENDER'] ||= config[:smtp]['user_name']

  ENV['TWITTER_KEY']    = config[:twitter]['key']
  ENV['TWITTER_SECRET'] = config[:twitter]['secret']  
end


Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'] , ENV['TWITTER_SECRET']
end

Esophagus::Application.config.secret_key_base = ENV['SECRET_KEY_BASE']

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_url_options = {host: ENV['HOST']}

smtp_settings = {}
smtp_settings[:address] = ENV['SMTP_ADDRESS'] if ENV['SMTP_ADDRESS']
smtp_settings[:port] = ENV['SMTP_PORT'] if ENV['SMTP_PORT']
smtp_settings[:domain] = ENV['SMTP_DOMAIN'] if ENV['SMTP_DOMAIN']
smtp_settings[:authentication] = ENV['SMTP_AUTHENTICATION'] if ENV['SMTP_AUTHENTICATION']
smtp_settings[:enable_starttls_auto] = ENV['SMTP_ENABLE_STARTTLS_AUTO'] if ENV['SMTP_ENABLE_STARTTLS_AUTO']
smtp_settings[:user_name] = ENV['SMTP_USER_NAME'] if ENV['SMTP_USER_NAME']
smtp_settings[:password] = ENV['SMTP_PASSWORD'] if ENV['SMTP_PASSWORD']

ActionMailer::Base.smtp_settings = smtp_settings