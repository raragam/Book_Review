class AddImpressionsCountToOpinions < ActiveRecord::Migration[6.1]
  def change
    add_column :opinions, :impressions_count, :integer
  end
end
