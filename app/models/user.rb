class User < ActiveRecord::Base
  attr_accessor :tweets

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
    get_latest_tweets

    while !all_newest_tweets_retrieved?
      get_more_tweets
    end

    update_attributes last_tweet_id: @tweets[0].id, scope_tweet_id: @tweets[1].id

    return @tweets
  end 

  def get_latest_tweets
    @tweets = client.home_timeline count: 200
  end

  def all_newest_tweets_retrieved?
    return true if last_tweet_id.nil?
    !@tweets.detect{|t| t.id == last_tweet_id}.blank?
  end

  def get_more_tweets
    more = client.home_timeline count: 200, since_id: scope_tweet_id, max_id: @tweets.last.id
    @tweets = @tweets + more
  end

  def digest
    TweetMailer.timeline(self, @tweets.reverse).deliver unless @tweets.empty?
  end

end
