class ChangeTwitterIdsToStrings < ActiveRecord::Migration
  def change
    change_column :users, :last_tweet_id, :string
    change_column :users, :scope_tweet_id, :string
  end
end
