class AddImpressionsCountToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :impressions_count, :integer, default: 0
  end
end
