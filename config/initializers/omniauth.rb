config = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]['twitter'].symbolize_keys

ENV['TWITTER_KEY']    = config[:key]
ENV['TWITTER_SECRET'] = config[:secret]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, config[:key], config[:secret]
end