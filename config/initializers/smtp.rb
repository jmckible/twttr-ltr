ActionMailer::Base.delivery_method = :smtp

config = YAML.load_file("#{Rails.root}/config/app.yml")[Rails.env]

mail_config = config['mail'].symbolize_keys
ActionMailer::Base.smtp_settings = mail_config

ActionMailer::Base.default_url_options = {host: config['host']}

ENV['SENDER'] = mail_config[:user_name]