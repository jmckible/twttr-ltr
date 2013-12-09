namespace :digest do

  task morning: :environment do
    User.morning.each do |user|
      begin
        user.get_tweets
        user.digest
      rescue Twitter::Error::TooManyRequests

      end
    end
  end

  task afternoon: :environment do
    User.afternoon.each do |user|
      begin
        user.get_tweets
        user.digest
      rescue Twitter::Error::TooManyRequests

      end
    end
  end

  task evening: :environment do
    User.evening.each do |user|
      begin
        user.get_tweets
        user.digest
      rescue Twitter::Error::TooManyRequests

      end
    end
  end

  task night: :environment do
    User.night.each do |user|
      begin
        user.get_tweets
        user.digest
      rescue Twitter::Error::TooManyRequests

      end
    end
  end


end