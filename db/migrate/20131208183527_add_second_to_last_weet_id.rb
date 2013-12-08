class AddSecondToLastWeetId < ActiveRecord::Migration
  def change
    add_column :users, :scope_tweet_id, :integer
  end
end
