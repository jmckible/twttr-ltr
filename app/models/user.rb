class User < ActiveRecord::Base

  def self.authenticate(omniauth)
    User.where(uid: omniauth['uid']).first_or_create(
      nickname: omniauth['info']['nickname'], 
      image: omniauth['info']['image'],
      token: omniauth['credentials']['token'],
      secret: omniauth['credentials']['secret']
    )
  end


  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = token
      config.access_token_secret = secret
    end
  end


  def get_tweets
    options = {}
    options[:since_id] = last_tweet_id if last_tweet_id
    tweets = client.home_timeline options
    user.update_attribute :last_tweet_id, tweets.first.id
    return tweets
  end 

  def digest
    tweets = ['one', 'two', 'three']
    TweetMailer.timeline(self, tweets).deliver unless tweets.empty?
  end

end
