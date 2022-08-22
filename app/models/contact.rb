class Contact < ApplicationRecord

  belongs_to :user

  validates :contact_title, presence: true
	validates :contact_body, presence: true

end
