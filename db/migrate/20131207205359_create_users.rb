class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid, :nickname, :image, :token, :secret
      t.timestamps
    end
    add_index :users, :uid
  end
end
