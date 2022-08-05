class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.string :review_title
      t.text :review_body
      t.string :book_name
      t.integer :user_id

      t.timestamps
    end
  end
end
