class OpinionComment < ApplicationRecord

  belongs_to :user
  belongs_to :opinion

  validates :opinion_comment, presence: true

end
