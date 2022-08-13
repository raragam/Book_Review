class ChangeFavoritesToOpinionFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_table :favorites, :opinion_favorites
  end
end
