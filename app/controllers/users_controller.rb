class UsersController < ApplicationController

  def show
    @user = current_user
    @tweets = User.stub_tweets
    render layout: 'test', template: 'tweet_mailer/timeline'
  end

  def update
    current_user.update_attributes params.require(:user).permit(:email, :morning, :afternoon, :evening)
    flash[:notice] = 'Settings Updated'
    redirect_to root_url
  end

  def deliver
    current_user.get_tweets
    current_user.digest
    flash[:notice] = 'Digest Delivered'
    redirect_to root_url
  end

  def deliver_test
    current_user.tweets = User.stub_tweets
    current_user.digest
    flash[:notice] = 'Digest Delivered'
    redirect_to root_url
  end

end