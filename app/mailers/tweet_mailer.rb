class TweetMailer < ActionMailer::Base
  helper :application

  def timeline(user, tweets)
    @user   = user
    @tweets = tweets

    mail to: user.email,
         from: "esophagus <#{ENV['SENDER']}>",
         subject: 'Twitter Digest'
  end

end