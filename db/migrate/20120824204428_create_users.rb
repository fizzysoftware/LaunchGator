class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :oauth_token
      t.datetime :oauth_expires_at
      t.string :uid
      t.string :provider
      t.timestamps
    end
  end
end
