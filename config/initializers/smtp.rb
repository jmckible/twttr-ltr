ActionMailer::Base.delivery_method = :smtp
config = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]['mail'].symbolize_keys
ActionMailer::Base.smtp_settings = config
ENV['SENDER'] = config[:user_name]