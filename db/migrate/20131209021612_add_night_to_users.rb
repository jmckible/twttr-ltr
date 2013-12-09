class AddNightToUsers < ActiveRecord::Migration
  def change
    add_column :users, :night, :boolean, default: false
    add_index  :users, :night
  end
end
