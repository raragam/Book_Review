class Favorite < ApplicationRecord

  belongs_to :user
  belongs_to :opinion
  belongs_to :review

end
