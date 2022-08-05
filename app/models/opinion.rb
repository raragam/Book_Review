class Opinion < ApplicationRecord

  belongs_to :user

  has_many :opinion_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :opinion_title, presence: true
  validates :opinion_body, presence: true
  validates :opinion_body, length: { minimum: 1, maximum: 200 }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
