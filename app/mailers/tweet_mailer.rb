class TweetMailer < ActionMailer::Base

  def timeline(user, tweets)
    @user   = user
    @tweets = tweets

    mail to: user.email,
         from: "<#{ENV['SENDER']}>",
         subject: 'Twitter Digest'
  end

end