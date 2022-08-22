class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|

      t.string :contact_title
      t.text :contact_body
      t.datetime :remember_created_at

      t.timestamps
    end
  end
end
