class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email
      t.integer :site_id
      t.string :unique_code
      t.integer :invites_count, :default => 0
      t.integer :inviter_id
      t.string :cookie
      t.string :short_url
      t.integer :views_count, :default => 0

      t.timestamps
    end
  end
end
