class AddDeliveryTimesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :morning, :boolean, default: false
    add_index  :users, :morning

    add_column :users, :afternoon, :boolean, default: false
    add_index  :users, :afternoon

    add_column :users, :evening, :boolean, default: false
    add_index  :users, :evening
  end
end
