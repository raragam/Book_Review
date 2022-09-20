class OpinionFavorite < ApplicationRecord

  belongs_to :user
  belongs_to :opinion

  validates_uniqueness_of :opinion_id, scope: :user_id

end
