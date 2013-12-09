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

  # For testing
  def self.stub_tweets
    [
      OpenStruct.new(id: 409762551455424512, text: 'Whoops I meant @RioTheatreSC obvs', user: OpenStruct.new(name: 'Kaki King', username: 'KakiKing', profile_image_url: 'http://pbs.twimg.com/profile_images/1541611628/t2As0hn4_normal')),
      OpenStruct.new(id: 409761289850716160, text: 'I like brussels sprouts. I like grilled cheese. I like them together as well. http://t.co/YKRfzKUipw', user: OpenStruct.new(name: 'J. Kenji López-Alt' , username: 'TheFoodLab', profile_image_url: 'http://pbs.twimg.com/profile_images/378800000499801341/6a72fc4474f9d1afaff4f90e501791fe_normal.jpeg')) 
      # OpenStruct.new(id: 409757537555066880),
      # OpenStruct.new(id: 409756563877134337),
      # OpenStruct.new(id: 409755349743202304),
      # OpenStruct.new(id: 409754306259058688),
      # OpenStruct.new(id: 409750608132837376),
      # OpenStruct.new(id: 409747326131916801),
      # OpenStruct.new(id: 409745072197226496),
      # OpenStruct.new(id: 409743996148146176)
    ]
  end

  scope :afternoon, ->{ where(afternoon: true) }
  scope :evening,   ->{ where(evening: true)   }
  scope :morning,   ->{ where(morning: true)   }
  scope :night,     ->{ where(night: true)     }

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

    last_tweet_id  = @tweets[0].id.to_s if @tweets[0]
    scope_tweet_id = @tweets[1].id.to_s if @tweets[1]
    save

    return @tweets
  end 

  def get_latest_tweets
    options = {}
    options[:count] = last_tweet_id.blank? ? 20 : 200
    options[:since_id] = scope_tweet_id if scope_tweet_id
    @tweets = client.home_timeline options
  end

  def all_newest_tweets_retrieved?
    return true if last_tweet_id.nil?
    !@tweets.detect{|t| t.id.to_s == last_tweet_id}.blank?
  end

  def get_more_tweets
    more = client.home_timeline count: 200, since_id: scope_tweet_id, max_id: @tweets.last.id
    @tweets = @tweets + more
  end

  def digest
    TweetMailer.timeline(self, @tweets.reverse).deliver unless @tweets.empty?
  end

end
