class CreateOpinionComments < ActiveRecord::Migration[6.1]
  def change
    create_table :opinion_comments do |t|

      t.text :opinion_comment
      t.integer :user_id
      t.integer :opinion_id

      t.timestamps
    end
  end
end
