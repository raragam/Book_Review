class CreateOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :opinions do |t|

      t.string :opinion_title
      t.string :opinion_body
      t.integer :user_id

      t.timestamps
    end
  end
end
