# es.ophag.us

Stop wasting time checking Twitter all day long. Instead, receive a digest of your timeline via email. 

## Installation

Fork and clone this repository.

Copy `config/database.yml.example` to `config.database.yml`. By default, sqlite is used

Copy `config/app.yml.example` to `config/app.yml`. Enter your local development host. For example, it might be `0.0.0.0:3000`. Generate a `secret_key_base` to secure your session (128 hex digits.)

Enter your mail server information. Defaults for GMail are provided.

Register an application with Twitter at [https://dev.twitter.com/apps/new](https://dev.twitter.com/apps/new)

Be sure to include a callback in the form of: `http://0.0.0.0:3000/auth/twitter/callback` and allow applications to "Sign in with Twitter"

Back in `app.yml`, enter your _consumer_ key and secret from Twitter.

## Usage

Browse to [http://0.0.0.0:3000](http://0.0.0.0:3000)

Click the Sign in with Twitter button and authorize access.

Once redirected back to your application, enter your email address and click Save Settings.

Test delivery by clicking the Deliver Now button

## Heroku

This repository can be deployed to Heroku. Since Heroku cannot use configuration files like `app.yml`, you must provide config values like so:

```$ heroku config:set HOST=mydomain.com```

You must set the following values:

```
HOST:                         mydomain.com
SECRET_KEY_BASE:              somehash
SMTP_ADDRESS:                 smtp.gmail.com
SMTP_AUTHENTICATION:          plain
SMTP_DOMAIN:                  gmail.com
SMTP_ENABLE_STARTTLS_AUTO:    true
SMTP_PASSWORD:                password
SMTP_PORT:                    587
SMTP_SENDER:                  username@gmail.com
SMTP_USER_NAME:               username@gmail.com
TWITTER_KEY:                  your_key
TWITTER_SECRET:               your_secret
```
