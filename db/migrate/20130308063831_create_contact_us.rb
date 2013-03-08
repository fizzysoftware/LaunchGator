class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.string :subject
      t.integer :phone_number

      t.timestamps
    end
  end
end
