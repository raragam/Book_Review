class Opinion < ApplicationRecord

  belongs_to :user

  has_many :opinion_comments, dependent: :destroy
  has_many :opinion_favorites, dependent: :destroy

  validates :opinion_title, presence: true
  validates :opinion_body, presence: true
  validates :opinion_body, length: { minimum: 1, maximum: 200 }

  #ブックマーク機能

  def favorited_by?(user)
    opinion_favorites.exists?(user_id: user.id)
  end

  #検索機能

  def self.search_for(content, method)
    if method == 'perfect'
      Opinion.where(opinion_title: content)
    elsif method == 'forward'
      Opinion.where('opinion_title LIKE ?', content+'%')
    elsif method == 'backward'
      Opinion.where('opinion_title LIKE ?', '%'+content)
    else
      Opinion.where('opinion_title LIKE ?', '%'+content+'%')
    end
  end

  #閲覧数
  is_impressionable counter_cache: true

end
