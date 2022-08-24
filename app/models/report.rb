class Report < ApplicationRecord

  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  enum status: { waiting: 0, keep: 1, complete: 2 }

  validates :reason, presence: true
  validates :url, presence: true

end
