class Contact < ApplicationRecord

  validates :contact_title, presence: true
	validates :contact_body, presence: true

end
