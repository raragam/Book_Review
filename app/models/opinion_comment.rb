class OpinionComment < ApplicationRecord

  belongs_to :user
  belongs_to :opinion

end
