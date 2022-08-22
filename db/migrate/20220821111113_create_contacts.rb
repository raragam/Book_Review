class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.string :contact_title
      t.text :contact_body
      t.text :reply
      t.integer :user_id

      t.timestamps
    end
  end
end
